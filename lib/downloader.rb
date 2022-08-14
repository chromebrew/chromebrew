require 'io/console'
require 'digest/sha2'
require_relative 'const'
require_relative 'color'
require_relative 'progress_bar'

begin
  require 'securerandom'
  require 'resolv-replace'
  require 'net/http'
rescue RuntimeError => e
  # hide the error message and fallback to curl if securerandom raise an error
  if e.message == 'failed to get urandom'
    Object.send(:remove_const, :CREW_USE_CURL)
    CREW_USE_CURL = true
  else
    abort e.full_message
  end
end

require 'uri'

def downloader (url, sha256sum, filename = File.basename(url), verbose = false)
  # downloader: wrapper for all Chromebrew downloaders (`net/http`,`curl`...)
  # Usage: downloader <url>, <sha256sum>, <filename::optional>, <verbose::optional>
  #
  #           <url>: URL that points to the target file
  #     <sha256sum>: SHA256 checksum, verify downloaded file with given checksum
  #      <filename>: (Optional) Output path/filename
  #       <verbose>: (Optional) Verbose output
  #
  uri = URI(url)

  unless CREW_USE_CURL or !ENV['CREW_DOWNLOADER'].to_s.empty?
    case uri.scheme
    when 'http', 'https'
      # use net/http if the url protocol is http(s)://
      http_downloader(uri, filename, verbose)
    when 'file'
      # use FileUtils to copy if it is a local file (the url protocol is file://)
      if File.exist?(uri.path)
        return FileUtils.cp(uri.path, filename)
      else
        abort "#{uri.path}: File not found :/".lightred
      end
    else
      # use external downloader (curl by default) if the url protocol is not http(s):// or file://
      external_downloader(uri, filename, verbose)
    end
  else
    # force using external downloader if either CREW_USE_CURL or ENV['CREW_DOWNLOADER'] is set
    external_downloader(uri, filename, verbose)
  end

  # verify with given checksum
  calc_sha256sum = Digest::SHA256.hexdigest( File.read(filename) )

  unless sha256sum =~ /^SKIP$/i or calc_sha256sum == sha256sum
    FileUtils.rm_f filename

    warn 'Checksum mismatch :/ Try again?'.lightred, <<~EOT
      #{''}
                            Filename: #{filename.lightblue}
          Expected checksum (SHA256): #{sha256sum.green}
        Calculated checksum (SHA256): #{calc_sha256sum.red}
    EOT

    exit 2
  end
end

def http_downloader (uri, filename = File.basename(url), verbose = false)
  # http_downloader: Downloader based on net/http library

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

        return send(__method__, redirect_uri, filename, verbose)
      else
        abort "Download failed with error #{response.code}: #{response.msg}".lightred
      end

      # get target file size (should be returned by the server)
      file_size = response['Content-Length'].to_f
      downloaded_size = 0.0

      # initialize progress bar
      progress_bar = ProgressBar.new(file_size)

      if verbose
        warn <<~EOT
          * Connected to #{uri.host} port #{uri.port}
          * HTTPS: #{uri.scheme.eql?('https')}
          *
        EOT

        # parse response's header to readable format
        response.to_hash.each_pair {|k, v| warn "> #{k}: #{v}" }

        warn "\n"
      end

      # read file chunks from server, write it to filesystem
      File.open(filename, 'wb') do |io|
        progress_bar_thread = progress_bar.show # print progress bar

        response.read_body do |chunk|
          downloaded_size += chunk.size # record downloaded size, used for showing progress bar
          progress_bar.set_downloaded_size(downloaded_size, invalid_size_error: false) if file_size.positive?

          io.write(chunk) # write to file
        end
      ensure
        # stop progress bar, wait for it to terminate
        progress_bar.progress_bar_showing = false
        progress_bar_thread.join
      end
    end
  end
end

def external_downloader (uri, filename = File.basename(url), verbose = false)
  # external_downloader: wrapper for external downloaders in CREW_DOWNLOADER (curl by default)

  # default curl cmdline, CREW_DOWNLOADER should be in this format also
  #   %<verbose>s: Will be substitute to "--verbose" if #{verbose} set to true, otherwise will be substitute to ""
  #      %<retry>: Will be substitute to #{CREW_DOWNLOADER_RETRY}
  #       %<url>s: Will be substitute to #{url}
  #    %<output>s: Will be substitute to #{filename}
  curl_cmdline = 'curl %<verbose>s -L -# --ssl --retry %<retry>s %<url>s -o %<output>s'

  # use CREW_DOWNLOADER if specified, use curl by default
  downloader_cmdline = CREW_DOWNLOADER || curl_cmdline

  return system(
    format(downloader_cmdline,
      {
        verbose: verbose ? '--verbose' : '',
        retry: CREW_DOWNLOADER_RETRY,
        url: uri.to_s,
        output: filename
      }
    ), exception: true
  )
end
