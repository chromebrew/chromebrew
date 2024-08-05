require 'io/console'
require 'digest/sha2'
require 'securerandom'
require 'resolv-replace'
require 'net/http'
require 'stringio'
require 'uri'
require_relative 'const'
require_relative 'color'
require_relative 'progress_bar'

class Downloader
  def self.download(url, sha256sum = 'SKIP', destination = File.basename(url), verbose = false)
    # download: wrapper for all Chromebrew downloaders (`net/http`,`git`...)
    # Usage: download <url>, <sha256sum>, <dest::optional>, <verbose::optional>
    #
    #           <url>: URL that points to the target file
    #     <sha256sum>: SHA256 checksum, verify downloaded file with given checksum
    #   <destination>: (Optional) Output destination
    #       <verbose>: (Optional) Verbose output
    #
    puts "Downloader.download(#{url}, #{sha256sum}, #{filename}, #{verbose})" if verbose
    uri = URI(url)

    unless %w[git git+https].include?(uri.scheme)
      dest_io = destination.eql?('-') ? StringIO.new : File.open(destination, 'wb')
    end

    case uri.scheme
    when 'http', 'https'
      # use net/http if the url protocol is http(s)://
      http_downloader(uri, sha256sum, dest_io, verbose)
    when 'git', 'git+https'
      # use git if the url protocol is git(+https)://
      git_downloader(uri, destination, verbose)
    when 'file'
      # copy from filesystem if the url protocol is file://
      file_downloader(uri, sha256sum, dest_io, verbose)
    end

    unless %w[git git+https].include?(uri.scheme)
      # close file IO on download completed
      dest_io.close

      # return file content if destination is '-'
      if destination == '-'
        # read underlying string from StringIO
        return dest_io.string
      end
    end
  end

  def self.http_downloader(uri, expected_sha, dest_io, verbose = false)
    # http_downloader: downloader based on net/http library
    ssl_error_retry      = 0
    sha256sum_calculator = Digest::SHA256.new

    # open http connection
    Net::HTTP.start(uri.host, uri.port, {
      max_retries: CREW_DOWNLOADER_RETRY,
          use_ssl: uri.scheme.eql?('https'),
      min_version: :TLS1_2,
          ca_file: SSL_CERT_FILE,
          ca_path: SSL_CERT_DIR
    }) do |http|
      http.request(Net::HTTP::Get.new(uri)) do |response|
        case
        when response.is_a?(Net::HTTPSuccess)
          # Response is successful, don't abort
        when response.is_a?(Net::HTTPRedirection) # follow HTTP redirection
          puts <<~EOT if verbose
            * Follow HTTP redirection: #{response['Location']}
            *
          EOT

          redirect_uri = URI(response['Location'])

          # add url scheme/host for redirected url based on original url if missing
          redirect_uri.scheme ||= uri.scheme
          redirect_uri.host   ||= uri.host

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
          response.to_hash.each_pair { |k, v| warn "> #{k}: #{v}" }

          warn "\n"
        end

        progress_bar_thread = progress_bar.show # print progress bar

        # read file chunks from server, write it to filesystem/memory
        begin
          response.read_body do |chunk|
            downloaded_size += chunk.size # record downloaded size, used for showing progress bar
            progress_bar.set_downloaded_size(downloaded_size, invalid_size_error: false) if file_size.positive?

            sha256sum_calculator.update(chunk) # pass chunk to checksum calculator
            dest_io.write(chunk)               # write to file
          end
        ensure
          # stop progress bar, wait for it to terminate
          progress_bar.progress_bar_showing = false
          progress_bar_thread.join
        end

        unless expected_sha.casecmp?('SKIP')
          sha256sum = sha256sum_calculator.hexdigest
          checksum_mismatch(expected_sha, sha256sum) unless expected_sha.eql?(sha256sum)
        end
      end
    end
  rescue OpenSSL::SSL::SSLError
    # handle SSL errors
    ssl_error_retry += 1
    ssl_error_retry <= 3 ? retry : raise
  end

  def self.git_downloader(uri, destination, verbose)
    url_params    = URI.decode_www_form(uri.query).to_h
    git_branch    = url_params['branch']
    git_hashtag   = url_params['hashtag']
    no_submodules = url_params['no_submodules'].eql?('1')

    FileUtils.mkdir_p destination
    Dir.chdir(destination) do
      system 'git', 'init'
      system 'git', 'config', 'advice.detachedHead', 'false' # suppress "You are in 'detached HEAD' state" warning
      system 'git', 'remote', 'add', 'origin', uri.rpartition('?')[0]
      system 'git', 'fetch', 'origin', (git_hashtag || git_branch)
      system 'git', 'checkout', 'FETCH_HEAD'
      system 'git', 'submodule', 'update', '--init', '--recursive' unless no_submodules
    end
  end

  def self.file_downloader(uri, expected_sha, dest_io, verbose)
    # use FileUtils to copy if it is a local file (the url protocol is file://)
    if File.exist?(uri.path)
      file_content = File.binread(uri.path)
      sha256sum    = Digest::SHA256.hexdigest(file_content)

      checksum_mismatch(expected_sha, sha256sum) unless expected_sha.casecmp?('SKIP')
      dest_io.write File.binread(uri.parh)
    else
      abort "#{uri.path}: File not found :/".lightred
    end
  end

  private_class_method

  def self.checksum_mismatch(expected, calculated)
    warn 'Checksum mismatch :/ Try again?'.lightred, '', <<~EOT
          Expected checksum (SHA256): #{expected.green}
        Calculated checksum (SHA256): #{calculated.red}
    EOT

    exit 2
  end
end
