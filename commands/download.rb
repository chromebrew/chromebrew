require 'fileutils'
require_relative '../lib/const'
require_relative '../lib/crew_lockfile'
require_relative '../lib/downloader'
require_relative '../lib/package_utils'

class Command
  def self.download(pkg, verbose: false, opt_source: false)
    abort 'Unable to download fake package.'.lightred if pkg.is_fake?

    url = PackageUtils.get_url(pkg, build_from_source: opt_source)
    sha256sum = PackageUtils.get_sha256(pkg, build_from_source: opt_source)

    source = pkg.source?(ARCH.to_sym) || opt_source
    # Check for a missing binary package and if so rebuild.
    if !source && pkg.superclass.to_s == 'Pip' && !(`curl -sI #{url}`.lines.first.split[1] == '200' && PackageUtils.get_gitlab_pkginfo(pkg.name, pkg.version, ARCH, false, false)[:pkg_sha256] == sha256sum)
      url = 'SKIP'
      source = true
    end

    uri = URI.parse url
    filename = File.basename(uri.path)
    # # If we're downloading a binary, reset the filename to what it would have been if we didn't download from the API.
    filename = "#{pkg.name}-#{pkg.version}-chromeos-#{ARCH}.#{pkg.binary_compression}" if filename.eql?('download')
    extract_dir = "#{pkg.name}.#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.dir"

    build_cachefile = File.join(CREW_CACHE_DIR, "#{pkg.name}-#{pkg.version}-build-#{ARCH}.tar.zst")
    return { source:, filename:, extract_dir: } if (CREW_CACHE_BUILD || pkg.cache_build?) && File.file?(build_cachefile) && !pkg.built

    if !url
      abort "No precompiled binary or source is available for #{ARCH}.".lightred
    elsif url.casecmp?('SKIP') || (pkg.no_source_build? || pkg.gem_compile_needed?)
      puts 'Skipping source download...'
    elsif opt_source
      puts 'Downloading source...'
    elsif !source
      puts 'Precompiled binary available, downloading...'
    else
      puts 'No precompiled binary available for your platform, downloading source...'
    end

    git = true unless pkg.git_hashtag.to_s.empty?
    gitlab_binary_url = "#{CREW_GITLAB_PKG_REPO}/generic/#{pkg.name}/#{pkg.version}_#{ARCH}/#{pkg.name}-#{pkg.version}-chromeos-#{ARCH}.#{pkg.binary_compression}"

    if (pkg.cache_build? || CREW_CACHE_BUILD) && !File.file?(build_cachefile) && !pkg.no_source_build? && !File.file?(File.join(CREW_CACHE_DIR, "#{pkg.name}-#{pkg.version}-chromeos-#{ARCH}.#{pkg.binary_compression}")) && `curl -fsI #{gitlab_binary_url}`.lines.first.split[1] != '200'

      build_cache_url = "#{CREW_GITLAB_PKG_REPO}/generic/#{pkg.name}/#{pkg.version}_#{ARCH}_build/#{pkg.name}-#{pkg.version}-build-#{ARCH}.tar.zst"
      puts 'Checking for cached build...'.orange
      # Does a remote build artifact exist?
      puts build_cache_url if verbose
      puts "curl -fsI #{build_cache_url}" if verbose
      if `curl -fsI #{build_cache_url}`.lines.first.split[1] == '200'
        gitlab_pkginfo = PackageUtils.get_gitlab_pkginfo(pkg.name, pkg.version, ARCH, true, true)
        gitlab_build_artifact_sha256 = gitlab_pkginfo[:pkg_sha256]
        gitlab_build_artifact_date = gitlab_pkginfo[:pkg_upload_date]
        puts "Cached build artifact from #{gitlab_build_artifact_date} exists! with sha256 #{gitlab_build_artifact_sha256}".lightgreen
        puts "Downloading most recent cached build artifact for #{pkg.name}-#{pkg.version}...".orange
        # Download the package build artifact.
        downloader(build_cache_url, gitlab_build_artifact_sha256, build_cachefile, no_update_hash: true)
        File.write "#{build_cachefile}.sha256", <<~BUILD_CACHEFILE_SHA256_EOF
          #{gitlab_build_artifact_sha256} #{build_cachefile}
        BUILD_CACHEFILE_SHA256_EOF
      end
    end

    Dir.chdir CREW_BREW_DIR do
      FileUtils.mkdir_p extract_dir
      # We want to skip when no_source_build is true during the build,
      # but when we have built a binary we are in upgrade, and we need
      # download since we need to extract the just generated binary.
      crewlog '(pkg.no_source_build? || pkg.gem_compile_needed?) && !pkg.in_upgrade && !pkg.in_install && caller.grep(/download_command/).empty?'
      crewlog "#{pkg.no_source_build?} || #{pkg.gem_compile_needed?} && #{!pkg.in_upgrade} && #{!pkg.in_install} && #{caller.grep(/download_command/).empty?}"
      next if (pkg.no_source_build? || pkg.gem_compile_needed?) && !pkg.in_upgrade && !pkg.in_install && caller.grep(/download_command/).empty?
      case File.basename(filename)
      # Sources that download with our internal downloader.
      # This also covers all precompiled binaries.
      when /\.zip$/i, /\.(tar(\.(gz|bz2|xz|lzma|lz|zst))?|tgz|tbz|tpxz|txz)$/i, /\.deb$/i, /\.AppImage$/i, /\.gem$/i
        # Recall file from cache if requested
        if CREW_CACHE_ENABLED || CREW_CACHE_BUILD || pkg.cache_build?
          outcome = cached_download(pkg, source, filename, extract_dir, verbose: verbose)
          # If the outcome is a hash, we're done here and we can return early.
          if outcome.is_a?(Hash)
            return outcome
          else
            # Otherwise, there wasn't a cached file, but we know where to make one.
            cachefile = outcome
          end
        end
        # Download file if not cached.
        downloader url, sha256sum, filename, verbose: verbose

        puts "#{pkg.name.capitalize} archive downloaded.".lightgreen
        # Stow file in cache if requested, if cachefile does not exist, and cache is writable.
        cache_downloaded_file(filename, verbose: verbose) if CREW_CACHE_ENABLED && !File.file?(cachefile) && File.writable?(CREW_CACHE_DIR)

        unless caller.grep(/download_command/).empty?
          puts 'Downloaded to: '.lightblue + File.join(CREW_BREW_DIR, filename).blue
          FileUtils.rm_rf extract_dir
        end
        return { source:, filename:, extract_dir: }

      when /^SKIP$/i
        FileUtils.mkdir_p extract_dir
      else
        unless git # We don't want to download a git repository as a file.
          FileUtils.mkdir_p extract_dir
          downloader url, sha256sum, filename, verbose: verbose

          puts "#{filename}: File downloaded.".lightgreen

          FileUtils.mv filename, "#{extract_dir}/#{filename}"
        end
      end

      # Handle git sources.
      if git
        # Recall repository from cache if requested
        if CREW_CACHE_ENABLED
          outcome = cached_git_download(pkg, source, filename, extract_dir, verbose: verbose)
          # If the outcome is a hash, we're done here and we can return early.
          if outcome.is_a?(Hash)
            return outcome
          else
            # Otherwise, there wasn't a cached git repository, but we know where to make one.
            cachefile = outcome
          end
        end
        # Download via git
        FileUtils.mkdir_p extract_dir
        Dir.chdir extract_dir do
          system 'git init'
          system 'git config advice.detachedHead false'
          system 'git config init.defaultBranch master'
          system "git remote add origin #{pkg.source_url}", exception: true
          system "git fetch #{'--depth 1' unless pkg.git_clone_deep?} origin #{pkg.git_hashtag}", exception: true
          system 'git checkout FETCH_HEAD'
          system 'git submodule update --init --recursive' unless pkg.no_git_submodules?
          system 'git fetch --tags', exception: true if pkg.git_fetchtags?
          puts 'Repository downloaded.'.lightgreen
        end
        # Stow file in cache if requested and cache is writable, except if
        # in Github Actions, since the cached git archive isn't shared
        # between parallel runs.
        cache_downloaded_git_repository(extract_dir, cachefile) if CREW_CACHE_ENABLED && File.writable?(CREW_CACHE_DIR) && !ENV['NESTED_CI']
      end
    end
    return { source:, filename:, extract_dir: }
  end
end

def cached_download(pkg, source, filename, extract_dir, verbose: false)
  puts "Looking for #{pkg.name} archive in cache".orange if verbose
  # Privilege CREW_LOCAL_BUILD_DIR over CREW_CACHE_DIR.
  local_build_cachefile = File.join(CREW_LOCAL_BUILD_DIR, filename)
  crew_cache_dir_cachefile = File.join(CREW_CACHE_DIR, filename)
  cachefile = File.file?(local_build_cachefile) ? local_build_cachefile : crew_cache_dir_cachefile
  # puts "Using #{pkg.name} archive from the build cache at #{cachefile}; The checksum will not be checked against the package file.".orange if cachefile.include?(CREW_LOCAL_BUILD_DIR)
  puts "Using #{pkg.name} archive from the build cache at #{cachefile}".orange
  if File.file?(cachefile)
    puts "#{pkg.name.capitalize} archive file exists in cache".lightgreen if verbose
    # Don't validate checksum if file is in the local build cache.
    if cachefile.include?(CREW_LOCAL_BUILD_DIR) || cachefile.include?(CREW_CACHE_DIR)
      sha256sum = 'SKIP'
    else
      calc_sha256sum = `sha256sum #{cachefile}`.chomp.split.first
    end
    if sha256sum =~ /^SKIP$/i || calc_sha256sum == sha256sum
      begin
        # Hard link cached file if possible.
        FileUtils.ln cachefile, CREW_BREW_DIR, force: true, verbose: verbose unless File.identical?(cachefile, "#{CREW_BREW_DIR}/#{filename}")
        puts 'Archive hard linked from cache'.green if verbose
      rescue StandardError
        # Copy cached file if hard link fails.
        FileUtils.cp cachefile, CREW_BREW_DIR, verbose: verbose unless File.identical?(cachefile, "#{CREW_BREW_DIR}/#{filename}")
        puts 'Archive copied from cache'.green if verbose
      end
      puts 'Archive found in cache'.lightgreen
      unless caller.grep(/download_command/).empty?
        puts 'Downloaded to: '.lightblue + File.join(CREW_BREW_DIR, filename).blue
        FileUtils.rm_rf extract_dir
      end
      return { source:, filename:, extract_dir: }
    else
      puts 'Cached archive checksum mismatch. 😔 Will download.'.lightred
    end
  else
    puts "Cannot find cached archive at #{cachefile}. 😔 Will download.".orange
    return cachefile
  end
end

def cache_downloaded_file(filename, verbose: false)
  # Hard link to cache if possible.
  FileUtils.ln filename, CREW_CACHE_DIR, verbose: verbose
  puts 'Archive hard linked to cache'.green if verbose
rescue StandardError
  # Copy to cache if hard link fails.
  FileUtils.cp filename, CREW_CACHE_DIR, verbose: verbose
  puts 'Archive copied to cache'.green if verbose
end

def cached_git_download(pkg, source, filename, extract_dir, verbose: false)
  cachefile = File.join(CREW_CACHE_DIR, "#{filename}_#{pkg.git_hashtag.gsub('/', '_')}.tar.zst")
  puts "Git cachefile is #{cachefile}".orange if verbose
  if File.file?(cachefile) && File.file?("#{cachefile}.sha256")
    while File.file?("#{cachefile}.lock")
      cache_wait_timer = 0
      puts "Waited #{cache_wait_timer}s for #{cachefile} generation..."
      sleep 1
      cache_wait_timer += 1
      abort "Cachefile not available after #{cache_wait_timer} seconds." if cache_wait_timer > 300
    end
    if Dir.chdir CREW_CACHE_DIR do
      system "sha256sum -c #{cachefile}.sha256"
    end
      FileUtils.mkdir_p extract_dir
      system "tar -Izstd -x#{'v' if verbose}f #{cachefile} -C #{extract_dir}"
      return { source:, filename:, extract_dir: }
    else
      puts 'Cached git repository checksum mismatch. 😔 Will download.'.lightred
    end
  else
    puts 'Cannot find cached git repository. 😔 Will download.'.lightred
  end

  return cachefile
end

def cache_downloaded_git_repository(extract_dir, cachefile)
  puts 'Caching downloaded git repo...'
  Dir.chdir extract_dir do
    # Do not use --exclude-vcs to exclude .git because some builds will use that information.
    git_cachefile_lockfile = CrewLockfile.new "#{cachefile}.lock"
    begin
      git_cachefile_lockfile.lock
      system "tar c \
        $(#{CREW_PREFIX}/bin/find -mindepth 1 -maxdepth 1 -printf '%P\n') | \
        nice -n 20 zstd -T0 --ultra -20 -o #{cachefile} -"
    ensure
      git_cachefile_lockfile.unlock
    end
  end
  system 'sha256sum', cachefile, out: "#{cachefile}.sha256" if File.file?(cachefile)
  puts 'Git repo cached.'.lightgreen
end
