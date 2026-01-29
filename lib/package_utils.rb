# lib/package_utils.rb
# Utility functions that take either a package object or a component of a package object as primary input.
require 'json'
require_relative 'const'
require_relative 'downloader'

class PackageUtils
  def self.installed?(pkg_name)
    device_json = JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'))
    return device_json['installed_packages'].any? { |elem| elem['name'] == pkg_name }
  end

  def self.compatible?(pkg)
    return (pkg.compatibility.casecmp?('all') || pkg.compatibility.include?(ARCH)) && (pkg.min_glibc.nil? || (pkg.min_glibc <= LIBC_VERSION)) && (pkg.max_glibc.nil? || (pkg.max_glibc >= LIBC_VERSION)) && !installed?(pkg.conflicts_with)
  end

  def self.incompatible_reason(pkg)
    reason = []
    reason.push "#{pkg.name.capitalize} is not compatible with #{ARCH}." if !pkg.compatibility.casecmp?('all') && !pkg.compatibility.include?(ARCH)
    reason.push "ChromeOS is currently running glibc #{LIBC_VERSION}, but the minimum version for #{pkg.name} is #{pkg.min_glibc}." if !pkg.min_glibc.nil? && (pkg.min_glibc >= LIBC_VERSION)
    reason.push "ChromeOS is currently running glibc #{LIBC_VERSION}, but the maximum version for #{pkg.name} is #{pkg.min_glibc}." if !pkg.max_glibc.nil? && (pkg.max_glibc.to_s <= LIBC_VERSION)
    reason.push "#{pkg.name.capitalize} conflicts with #{pkg.conflicts_with.capitalize}, which is currently installed." if installed?(pkg.conflicts_with)
    return reason
  end

  def self.get_url(pkg, build_from_source: false)
    if !build_from_source && pkg.binary_sha256&.key?(ARCH.to_sym)
      return get_binary_url(pkg)
    elsif pkg.source_url.is_a?(Hash) && pkg.source_url&.key?(ARCH.to_sym)
      return pkg.source_url[ARCH.to_sym]
    else
      return pkg.source_url
    end
  end

  def self.get_sha256(pkg, build_from_source: false)
    if !build_from_source && pkg.binary_sha256&.key?(ARCH.to_sym)
      return pkg.binary_sha256[ARCH.to_sym]
    elsif pkg.source_sha256.is_a?(Hash) && pkg.source_sha256&.key?(ARCH.to_sym)
      return pkg.source_sha256[ARCH.to_sym]
    else
      return pkg.source_sha256
    end
  end

  def self.get_binary_url(pkg)
    # Fall back to the old method of querying if the gitlab API doesn't work for whatever reason.
    fallback_url = "#{CREW_GITLAB_PKG_REPO}/generic/#{pkg.name}/#{pkg.version}_#{ARCH}/#{pkg.name}-#{pkg.version}-chromeos-#{ARCH}.#{pkg.binary_compression}"

    # List all the packages with the name and version of the package file.
    # The name search is fuzzy, so we need to refine it further (otherwise packages like vim, gvim and vim_runtime would break).
    pkg_json_download_try_count = 3
    packages = nil
    while pkg_json_download_try_count.positive? || packages.nil?
      pkg_json_download_try_count -= 1
      pkg_json_response = get_http_response("#{CREW_GITLAB_PKG_REPO}?package_name=#{pkg.name}&package_version=#{pkg.version}_#{ARCH}")
      pkg_json_response_code = pkg_json_response.code
      if pkg_json_response_code != '200'
        puts pkg_json_response.header.to_s.orange
        redo
      end
      begin
        packages = JSON.parse(pkg_json_response.body)
      rescue JSON::ParserError
        puts "#{CREW_GITLAB_PKG_REPO}?package_name=#{pkg.name}&package_version=#{pkg.version}_#{ARCH} is not valid JSON.".orange
        puts 'Retrying download...'.orange
        packages = nil
      end
    end

    # Loop over each result until we get an exact name match, then return the package ID for that match.
    package_id = packages.select(&->(p) { p['name'] == pkg.name }).dig(0, 'id') unless packages.nil?

    # Return early if we weren't able to find the package ID, so that the CREW_CACHE_ENABLED hack to test packages without uploading them still works.
    # When we're doing that, we're calling download knowing that there isn't an actual file to download, but relying on CREW_CACHE_ENABLED to save us before we get there.
    return fallback_url unless package_id

    # List all the package files for that package ID.
    response      = get_http_response("#{CREW_GITLAB_PKG_REPO}/#{package_id}/package_files")
    package_files = JSON.parse(response.body)

    # Bail out if we weren't actually able to find a package.
    return fallback_url if package_files.is_a?(Hash) && package_files['message'] == '404 Not found'

    # Loop over each result until we find a matching file_sha256 to our binary_sha256.
    file_id = package_files.select(&->(p) { p['file_sha256'] == pkg.binary_sha256[ARCH.to_sym] }).dig(0, 'id')

    return "https://gitlab.com/chromebrew/binaries/-/package_files/#{file_id}/download" if file_id

    # If we're still here, the likely cause is that the file sha256s are mismatched.
    return fallback_url
  end

  def self.get_clean_version(pkg_version)
    new_version = pkg_version.dup
    # Delete debian versions for packages like libdb.
    new_version.gsub!(/-dfsg.*/, '')
    # Delete -gcc14
    new_version.gsub!(/-gcc(\d+)/, '')
    # Delete -glibc2.37, or whatever the system glibc is.
    new_version.delete_suffix!("-glibc#{LIBC_VERSION}")
    # Delete -icuXX.Y
    new_version.gsub!(/-icu(\d+)\.\d/, '')
    # Trim kde- prefixes in qt5 packages so nothing else gets confused.
    new_version.delete_prefix!('kde-')
    # Delete -llvm18
    new_version.gsub!(/-llvm(\d+)/, '')
    # Delete -perlX.YYYYY
    new_version.gsub!(/-perl\d\.\d+/, '')
    # Delete -pyX.YY
    new_version.gsub!(/-py\d\.\d+/, '')
    # Delete -ruby4.X
    new_version.gsub!(/-ruby\d\.\d{1}/, '')
    # Delete -rustX.YY
    new_version.gsub!(/-rust\d\.\d+/, '')
    # Delete git version tags (1.2.4-qnd73k6), avoiding overmatching and hitting things that arent git hashtags.
    new_version.gsub!(/-\w{7}$/, '')

    return new_version
  end

  def self.get_gem_vars(passed_name = nil, passed_version = nil, upstream_name = nil)
    require_relative 'gem_compact_index_client'
    # crewlog "Setting gem variables... name: #{passed_name}, version: #{passed_version}"
    # This assumes the package class name starts with 'Ruby_' and
    # version is in the form '(gem version)-ruby-(ruby version)'.
    # For example, name 'Ruby_awesome' and version '1.0.0-ruby-3.3'.
    # Just use the fetcher.suggest_gems_from_name function to figure out
    # proper gem name with the appropriate dashes and underscores.
    if CREW_VERY_VERBOSE
      # Voluminous info about the gem fetcher network connection...
      require 'rubygems/request'
      Gem::Request.prepend(Module.new do
        def perform_request(req)
          super.tap { |rsp| p [self, req, rsp] }
        end
      end)
    end
    if $gems.blank?
      puts 'Populating gem information using compact index client...'.lightgreen
      $gems ||= BasicCompactIndexClient.new.gems
      puts 'Done populating gem information.'.lightgreen
    end
    # Parse gem information from compact index, the format for which is
    # here: https://guides.rubygems.org/rubygems-org-compact-index-api/
    # Figure out gem name, noting that there may be dashes and underscores
    # in the name.
    if upstream_name.nil?
      gem_test = $gems.grep(/#{"^#{passed_name.gsub(/^ruby_/, '')}\\s.*$"}/).last.blank? ? $gems.grep(/#{"^\(#{passed_name.gsub(/^ruby_/, '').gsub('_', ')+.(')}\\s\).*$"}/).last : $gems.grep(/#{"^#{passed_name.gsub(/^ruby_/, '')}\\s.*$"}/).last
      abort "Cannot find #{passed_name} gem to install.".lightred if gem_test.blank?
      gem_test_name = gem_test.split.first
      ruby_gem_name = gem_test_name.blank? ? Gem::SpecFetcher.fetcher.suggest_gems_from_name(passed_name.gsub(/^ruby_/, '')).first : gem_test_name
    else
      ruby_gem_name = upstream_name
      gem_test = $gems.grep(/#{"^#{ruby_gem_name}\\s.*$"}/).last
    end
    gem_test_versions = gem_test.split[1].split(',')
    # Remove minus prefixed versions, as those have been yanked as per
    # https://guides.rubygems.org/rubygems-org-compact-index-api/
    gem_test_versions.delete_if { |i| i.start_with?('-') }
    # Any version with a letter is considered a prerelease as per
    # https://github.com/rubygems/rubygems/blob/b5798efd348935634d4e0e2b846d4f455582db48/lib/rubygems/version.rb#L305
    gem_test_versions.delete_if { |i| i.match?(/[a-zA-Z]/) }
    gem_test_version = gem_test_versions.map { |v| Gem::Version.new(v) }.max.to_s
    remote_gem_version_test = Gem.latest_version_for(ruby_gem_name).to_s
    remote_ruby_gem_version = remote_gem_version_test.blank? ? gem_test_version : Gem.latest_version_for(ruby_gem_name).to_s
    ruby_gem_version = passed_version.split('-').first.to_s
    # Use latest gem version.
    ruby_gem_version = remote_ruby_gem_version.to_s if Gem::Version.new(remote_ruby_gem_version.to_s) > Gem::Version.new(ruby_gem_version)
    require_relative 'gem_compact_index_client_deps'

    deps = BasicCompactIndexClientDeps.new.deps(ruby_gem_name)
    gem_deps = deps.grep(/#{"^#{ruby_gem_version}\\s.*$"}/).last.gsub(/^#{ruby_gem_version} /, '').gsub(/\|.*$/, '').split(',').map { |dep| dep.gsub(/:.*$/, '') }
    gem_installed_version = nil
    gem_outdated = nil
    gem_latest_version_installed = false
    installed_gem_search = [`gem list --no-update-sources -l -e #{ruby_gem_name}`.chomp.to_s].grep(/#{ruby_gem_name}/)[0]
    if installed_gem_search
      installed_gem_info = installed_gem_search.delete('()').gsub('default:', '').gsub(',', '').split
      gem_installed_version = installed_gem_info[1]
      gem_outdated = (Gem::Version.new(ruby_gem_version) > Gem::Version.new(gem_installed_version))
      gem_latest_version_installed = Gem::Version.new(ruby_gem_version) <= Gem::Version.new(gem_installed_version)
    else
      # If the current gem being installed is not installed this should
      # be false. This will also handle cases of the current installed
      # gem as per 'gem list' being the same version as the version
      # being upgraded to.
      gem_latest_version_installed = false
    end
    crewlog "ruby_gem_name: #{ruby_gem_name} ruby_gem_version: #{ruby_gem_version} gem_installed_version: #{gem_installed_version} gem_outdated: #{gem_outdated} gem_latest_version_installed: #{gem_latest_version_installed}" if CREW_VERY_VERBOSE

    return ruby_gem_name, ruby_gem_version, remote_ruby_gem_version, gem_installed_version, gem_latest_version_installed, gem_outdated, gem_deps
  end

  # Remove our language-specific prefixes and any build splitting suffixes.
  # This is mostly for use when querying Anitya in tools/version.rb, and is not suitable for Repology.
  def self.get_clean_name(pkg_name)
    cleaned_name = pkg_name.dup
    # Delete language-specific prefixes.
    cleaned_name.delete_prefix!('perl_')
    cleaned_name.delete_prefix!('py3_')
    cleaned_name.delete_prefix!('ruby_')
    # Delete suffixes for split packages.
    cleaned_name.delete_suffix!('_build')
    cleaned_name.delete_suffix!('_dev')
    cleaned_name.delete_suffix!('_lib')
    # Delete the _static suffix for statically built packages.
    cleaned_name.delete_suffix!('_static')

    return cleaned_name
  end

  def self.get_gitlab_pkginfo(pkg_name, pkg_version, pkg_arch, build = nil, verbose = nil)
    # This is largely rehashing self.get_binary_url(pkg) using the
    # curl and jq binaries for debugging purposes.
    # outputs are :pkg_file_name, :pkg_sha256, :pkg_upload_date :pkg_url
    # Usage:
    # gitlab_pkginfo = PackageUtils.get_gitlab_pkginfo(package, pkg_version, arch, true)
    # binary_sha256_hash[arch.to_sym] = gitlab_pkginfo[:pkg_sha256]

    verbose = CREW_VERBOSE if verbose.nil?
    # Let's avoid for now an early abort in case we are looking for a
    # package with a non-standard binary_compression.
    # fallback_url = "#{CREW_GITLAB_PKG_REPO}/generic/#{pkg_name}/#{pkg_version}_#{pkg_arch}/#{pkg_name}-#{pkg_version}-chromeos-#{pkg_arch}.#{pkg.binary_compression}"
    # abort "Gitlab upload at #{fallback_url} not found."lightred unless `curl -fsI "#{fallback_url}"`.lines.first.split[1] == '200'

    # What is the gitlab package binary PACKAGE_ID?

    crewlog 'curl -s --location \\'
    crewlog "#{CREW_GITLAB_PKG_REPO}?package_type=generic&package_name=#{pkg_name}&package_version=#{pkg_version}_#{pkg_arch}#{'_build' if build}"
    gitlab_binary_pkg_id = `curl -s --location \
    "#{CREW_GITLAB_PKG_REPO}?package_type=generic&package_name=#{pkg_name}&package_version=#{pkg_version}_#{pkg_arch}#{'_build' if build}" \
         | jq -r ".[] | select(.name==\\"#{pkg_name}\\" and .version==\\"#{pkg_version}_#{pkg_arch}#{'_build' if build}\\") | .id"`.chomp
    # Need fallback for complicated versions like in w3m.
    if gitlab_binary_pkg_id.blank?
      gitlab_binary_pkg_id = `curl -s --location \
    "#{CREW_GITLAB_PKG_REPO}?package_type=generic&package_name=#{pkg_name}" \
         | jq -r ".[] | select(.name==\\"#{pkg_name}\\" and .version==\\"#{pkg_version}_#{pkg_arch}#{'_build' if build}\\") | .id"`.chomp
    end
    crewlog "gitlab_binary_pkg_id is #{gitlab_binary_pkg_id}" if verbose
    # What is the hash of the gitlab package remote binary file name?
    pkg_file_name = `curl -s --location \
    "#{CREW_GITLAB_PKG_REPO}/#{gitlab_binary_pkg_id}/package_files" \
         | jq -r "last(.[].file_name)"`.chomp
    crewlog "pkg_file_name is #{pkg_file_name}" if verbose
    # What is the hash of the gitlab package remote binary?
    pkg_sha256 = `curl -s --location \
    "#{CREW_GITLAB_PKG_REPO}/#{gitlab_binary_pkg_id}/package_files" \
         | jq -r "last(.[].file_sha256)"`.chomp
    # What is the upload date of this gitlab package remote binary?
    pkg_upload_date = `curl -s --location \
    "#{CREW_GITLAB_PKG_REPO}/#{gitlab_binary_pkg_id}/package_files" \
         | jq -r "last(.[].created_at)"`.chomp
    crewlog "pkg_upload_date is #{pkg_upload_date}" if verbose
    pkg_url = "#{CREW_GITLAB_PKG_REPO}/generic/#{pkg_name}/#{pkg_version}_#{pkg_arch}/#{pkg_file_name}"
    puts "\e[1A\e[K#{pkg_name.capitalize} #{pkg_version} has a#{'n' if pkg_arch.start_with?('a', 'e', 'i', 'o', 'u')} #{pkg_arch} upload on Gitlab.\n".green
    puts "\e[1A\e[K sha256: #{pkg_sha256}\n uploaded: #{pkg_upload_date}\n url: #{pkg_url}\n".orange if verbose
    return { pkg_file_name: pkg_file_name, pkg_sha256: pkg_sha256, pkg_upload_date: pkg_upload_date, pkg_url: pkg_url }
  end
end
