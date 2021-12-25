require 'io/console'
require 'net/http'
require 'uri'
require_relative 'const'
require_relative 'color'
require_relative 'convert_size'

def setTermSize
  # setTermSize: set progress bar size based on terminal width
  # get terminal window size
  @termH, @termW = IO.console.winsize
  # space for progress bar after minus the reserved space for showing
  # the file size and progress percentage
  @progBarW = @termW - 17
  return true
end

def downloader (url, filename = File.basename(url), retry_count = 0, verbose = false)
  setTermSize
  # reset width settings after terminal resized
  trap('WINCH') { setTermSize }
  uri = URI(url)

  case uri.scheme
  when /http?/
  when 'file'
    # use FileUtils to copy if it is a local file (the url protocol is file://)
    if File.exist?(uri.path)
      return FileUtils.cp uri.path, filename
    else
      abort "#{uri.path}: No such file :/".lightred
    end
  else
    # fallback to curl if the url protocol is not http(s):// or file://
    0.step(3,1) do |i|
      unless system "#{CURL} --ssl -#L -C - '#{uri.to_s}' -o '#{filename}'"
        puts "Retrying, #{3-i} retries left.".yellow
      else
        return true
      end
    end
    # the download failed if we're still here
    abort 'Download failed :/ Please check your network settings.'.lightred
  end

  Net::HTTP.start(uri.host, uri.port, {
      max_retries: 3,
      use_ssl: uri.scheme.eql?('https'),
      ca_file: SSL_CERT_FILE,
      ca_path: SSL_CERT_DIR
  }) do |http|
    http.request( Net::HTTP::Get.new(uri) ) do |response|
      case
      when response.is_a?(Net::HTTPOK)
      when response.is_a?(Net::HTTPRedirection) # follow HTTP redirection
        puts <<~EOT if verbose
          * Follow HTTP redirection: #{response['Location']}
          *
        EOT
        return downloader(response['Location'], filename, retry_count, verbose)
      else
        abort "Download failed with error #{response.code}: #{response.msg}".lightred
      end

      # get target file size (should be returned by the server)
      file_size = response['Content-Length'].to_i
      downloaded_size = 0

      if verbose
        puts <<~EOT
          * Connected to #{uri.host} port #{uri.port}
          * HTTPS: #{uri.scheme.eql?('https')}
          *
        EOT

        response.to_hash.each_pair do |k, v|
          puts "> #{k}: #{v}"
        end
        puts
      end

      File.open(filename, 'wb') do |io|
        response.read_body do |chunk|
          downloaded_size += chunk.size
          if file_size.positive?
            # calculate downloading progress percentage with the given file size
            percentage = (downloaded_size.to_f / file_size.to_f) * 100
            # show progress bar, file size and progress percentage
            printf "\r[%-#{@progBarW}s] %9.9s %3d%%",
                   '#' * ( @progBarW * (percentage / 100) ).to_i,
                   human_size(file_size),
                   percentage
          end
          io.write(chunk)
        end
      end
      puts
    end
  end
end
