require 'io/console'
require 'digest/sha2'
require_relative 'const'
require_relative 'color'
require_relative 'convert_size'

begin
  require 'securerandom'
rescue RuntimeError => e
  # hide the error message and fallback to curl if securerandom raise an error
  if e.message == 'failed to get urandom'
    Object.send(:remove_const, :CREW_USE_CURL)
    CREW_USE_CURL = true
  else
    abort e.full_message
  end
end

require 'net/http'
require 'uri'
require 'resolv-replace'

def setTermSize
  # setTermSize: set progress bar size based on terminal width
  # get terminal window size
  begin
    @termH, @termW = IO.console.winsize
  rescue NoMethodError => e
    unless @warned
      STDERR.puts 'Non-interactive terminals may not be able to be queried for size.'
      @warned = true
    end

    @termH, @termW = [ 25, 80 ]
  end
  # space for progress bar after minus the reserved space for showing
  # the file size and progress percentage
  @progBarW = @termW - 17
  return true
end

def downloader (url, sha256sum, filename = File.basename(url), verbose = false)
  # downloader: wrapper for all Chromebrew downloaders (`net/http`,`curl`...)
  # Usage: downloader <url>, <sha256sum>, <filename::optional>, <verbose::optional>
  #
  #           <url>: URL that points to the target file
  #     <sha256sum>: SHA256 checksum, verify downloaded file with given checksum
  #      <filename>: (Optional) Output path/filename
  #       <verbose>: (Optional) Verbose output
  #
  setTermSize
  # reset width settings after terminal resized
  trap('WINCH') { setTermSize }

  uri = URI(url)

  unless CREW_USE_CURL or !ENV['CREW_DOWNLOADER'].to_s.empty?
    case uri.scheme
    when 'http', 'https'
      # use net/http if the url protocol is http(s)://
      http_downloader(url, filename, verbose)
    when 'file'
      # use FileUtils to copy if it is a local file (the url protocol is file://)
      if File.exist?(uri.path)
        return FileUtils.cp uri.path, filename
      else
        abort "#{uri.path}: File not found :/".lightred
      end
    else
      # use external downloader (curl by default) if the url protocol is not http(s):// or file://
      external_downloader(url, filename, verbose)
    end
  else
    # force using external downloader if either CREW_USE_CURL or ENV['CREW_DOWNLOADER'] is set
    external_downloader(url, filename, verbose)
  end

  # verify with given checksum
  unless sha256sum =~ /^SKIP$/i or Digest::SHA256.hexdigest( File.read(filename) ) == sha256sum
    abort 'Checksum mismatch :/ Try again?'.lightred
  end
end

def http_downloader (url, filename = File.basename(url), verbose = false)
  # http_downloader: Downloader based on net/http library

  uri = URI(url)

  # open http connection
  Net::HTTP.start(uri.host, uri.port, {
      max_retries: CREW_DOWNLOADER_RETRY,
      use_ssl: uri.scheme.eql?('https'),
      ca_file: SSL_CERT_FILE,
      ca_path: SSL_CERT_DIR
  }) do |http|
    http.request( Net::HTTP::Get.new(uri) ) do |response|
      case
      when response.is_a?(Net::HTTPSuccess)
      when response.is_a?(Net::HTTPRedirection) # follow HTTP redirection
        puts <<~EOT if verbose
          * Follow HTTP redirection: #{response['Location']}
          *
        EOT

        redirect_uri = URI(response['Location'])

        # add url scheme/host for redirected url based on original url if missing
        redirect_uri.scheme ||= uri.scheme
        redirect_uri.host ||= uri.host

        return send(__method__, redirect_uri.to_s, filename, verbose)
      else
        abort "Download failed with error #{response.code}: #{response.msg}".lightred
      end

      # get target file size (should be returned by the server)
      file_size = response['Content-Length'].to_f
      downloaded_size = 0.0

      if verbose
        puts <<~EOT
          * Connected to #{uri.host} port #{uri.port}
          * HTTPS: #{uri.scheme.eql?('https')}
          *
        EOT

        # parse response's header to readable format
        response.to_hash.each_pair {|k, v| puts "> #{k}: #{v}" }

        puts
      end

      # read file chunks from server, write it to filesystem
      File.open(filename, 'wb') do |io|
        response.read_body do |chunk|
          unless CREW_HIDE_PROGBAR
            downloaded_size += chunk.size # record downloaded size, used for showing progress bar
            if file_size.positive?
              # calculate downloading progress percentage with the given file size
              percentage = (downloaded_size / file_size) * 100
              # show progress bar, file size and progress percentage
              printf "\r""[%-#{@progBarW}.#{@progBarW}s] %9.9s %3d%%",
                     '#' * ( @progBarW * (percentage / 100) ),
                     human_size(file_size),
                     percentage
            end
          end
          io.write(chunk) # write to file
        end
      end
      puts
    end
  end
end

def external_downloader (url, filename = File.basename(url), verbose = false)
  # external_downloader: wrapper for external downloaders in CREW_DOWNLOADER (curl by default)

  # default curl cmdline, CREW_DOWNLOADER should be in this format also
  #   %<verbose>s: Will be substitute to "--verbose" if #{verbose} set to true, otherwise will be substitute to ""
  #      %<retry>: Will be substitute to #{CREW_DOWNLOADER_RETRY}
  #       %<url>s: Will be substitute to #{url}
  #    %<output>s: Will be substitute to #{filename}
  curl_cmdline = 'curl %<verbose>s -L -# --ssl --retry %<retry>s %<url>s -o %<output>s'

  # use CREW_DOWNLOADER if specified, use curl by default
  downloader_cmdline = CREW_DOWNLOADER || curl_cmdline

  return system (downloader_cmdline % { verbose: verbose ? '--verbose' : '', retry: CREW_DOWNLOADER_RETRY, url: url, output: filename}), exception: true
end
