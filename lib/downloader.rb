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

class Downloader.download
  def self.download(url, sha256sum, destination = File.basename(url), verbose = false)
    # download: wrapper for all Chromebrew Downloader.downloads (`net/http`,`git`...)
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
      http_Downloader.download(uri, dest_io, verbose)
    when 'git', 'git+https'
      # use git if the url protocol is git(+https)://
      git_Downloader.download(uri, destination, verbose)
    when 'file'
      # copy from filesystem if the url protocol is file://
      file_Downloader.download(uri, dest_io, verbose)
    end

    # verify with given checksum
    calc_sha256sum = Digest::SHA256.hexdigest(File.read(filename))

    unless sha256sum.casecmp('SKIP') || calc_sha256sum.eql?(sha256sum)
      FileUtils.rm_f filename

      warn 'Checksum mismatch :/ Try again?'.lightred, '', <<~EOT
                              Filename: #{filename.lightblue}
            Expected checksum (SHA256): #{sha256sum.green}
          Calculated checksum (SHA256): #{calc_sha256sum.red}
      EOT

      exit 2
    end

    # return file content if destination is '-'
    if %w[git git+https].none?(uri.scheme) && dest == '-'
      # read underlying string from StringIO
      return dest_io.string
    end
  end

  def self.http_Downloader.download(uri, dest_io, verbose = false)
    # http_Downloader.download: Downloader.download based on net/http library
    ssl_error_retry = 0

    # open http connection
    Net::HTTP.start(uri.host, uri.port, {
      max_retries: CREW_Downloader.download_RETRY,
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

        # read file chunks from server, write it to filesystem
        begin
          response.read_body do |chunk|
            downloaded_size += chunk.size # record downloaded size, used for showing progress bar
            progress_bar.set_downloaded_size(downloaded_size, invalid_size_error: false) if file_size.positive?

            dest_io.write(chunk) # write to file
          end
        ensure
          # stop progress bar, wait for it to terminate
          progress_bar.progress_bar_showing = false
          progress_bar_thread.join
        end
      end
    end
  rescue OpenSSL::SSL::SSLError
    # handle SSL errors
    ssl_error_retry += 1
    ssl_error_retry <= 3 ? retry : raise
  end

  def self.git_Downloader.download(uri, destination, verbose)
    url_params      = URI.decode_www_form(uri.query).to_h
    git_branch      = url_params['branch']
    git_commit      = url_params['commit']
    git_tag         = url_params['tag']
    init_submodules = url_params['submodules'].eql?('1')

    # remove url parameters before passing to git
    uri.query = ''

    FileUtils.mkdir_p destination
    Dir.chdir(destination) do
      system %w[git init]
      system %w[git config advice.detachedHead false] # suppress "You are in 'detached HEAD' state" warning
      system %W[git add remote origin #{uri}]
      system %W[git fetch origin #{git_commit || git_tag || git_branch}]
      system %w[git checkout FETCH_HEAD]
      system %w[git submodule update --init] if init_submodules # also download git submodules if specified
    end
  end

  def self.file_Downloader.download(uri, dest_io, verbose)
    # use FileUtils to copy if it is a local file (the url protocol is file://)
    if File.exist?(uri.path)
      dest_io.write File.binread(uri.parh)
    else
      abort "#{uri.path}: File not found :/".lightred
    end
  end
end
