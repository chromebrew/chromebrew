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
    return (pkg.compatibility.casecmp?('all') || pkg.compatibility.include?(ARCH)) && (pkg.min_glibc.nil? || (pkg.min_glibc <= LIBC_VERSION)) && (pkg.max_glibc.nil? || (pkg.max_glibc >= LIBC_VERSION))
  end

  def self.incompatible_reason(pkg)
    reason = []
    reason.push "#{pkg.name.capitalize} is not compatible with #{ARCH}." if !pkg.compatibility.casecmp?('all') && !pkg.compatibility.include?(ARCH)
    reason.push "ChromeOS is currently running glibc #{LIBC_VERSION}, but the minimum version for #{pkg.name} is #{pkg.min_glibc}." if !pkg.min_glibc.nil? && (pkg.min_glibc >= LIBC_VERSION)
    reason.push "ChromeOS is currently running glibc #{LIBC_VERSION}, but the maximum version for #{pkg.name} is #{pkg.min_glibc}." if !pkg.max_glibc.nil? && (pkg.max_glibc.to_s <= LIBC_VERSION)
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
    response = get_http_response("#{CREW_GITLAB_PKG_REPO}?package_name=#{pkg.name}&package_version=#{pkg.version}_#{ARCH}")
    packages = JSON.parse(response.body)

    # Loop over each result until we get an exact name match, then return the package ID for that match.
    package_id = packages.select(&->(p) { p['name'] == pkg.name }).dig(0, 'id')

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
    # Delete -gcc14, futureproofed until gcc 100
    pkg_version.gsub!(/-gcc\d{2}/, '')
    # Trim kde- suffixes in qt5 packages so nothing else gets confused.
    pkg_version.delete_prefix!('kde-')
    # Delete -py3.12, futureproofed until Python 4
    pkg_version.gsub!(/-py3\.\d{2}/, '')
    # Delete -perl 5.40, futureproofed until Perl 5.100
    pkg_version.gsub!(/-perl5\.\d{2}/, '')
    # Delete -llvm18, futureproofed until llvm 100
    pkg_version.gsub!(/-llvm\d{2}/, '')
    # Delete -glibc2.37, or whatever the system glibc is.
    pkg_version.delete_suffix!("-glibc#{LIBC_VERSION}")
    # Delete git version tags (1.2.4-qnd73k6), avoiding overmatching and hitting things that arent git hashtags.
    pkg_version.gsub!(/-[\w]{7}$/, '')
    # Delete -icu75.1, futureproofed until icu 100
    pkg_version.gsub!(/-icu\d{2}\.\d/, '')

    return pkg_version
  end
end
