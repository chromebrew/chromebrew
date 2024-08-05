require 'json'
require 'net/http'
require_relative 'const'

class PackageUtils
  def self.installed?(pkg_name)
    device_json = JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'))
    return device_json['installed_packages'].any? { |elem| elem['name'] == pkg_name }
  end

  def self.compatible?(pkg)
    return pkg.compatibility.casecmp?('all') || pkg.compatibility.include?(ARCH)
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
    # List all the packages with the name and version of the package file.
    # The name search is fuzzy, so we need to refine it further (otherwise packages like vim, gvim and vim_runtime would break).
    packages = JSON.parse(Net::HTTP.get(URI("https://gitlab.com/api/v4/projects/26210301/packages?package_name=#{pkg.name}&package_version=#{pkg.version}_#{ARCH}")))
    # Loop over each result until we get an exact name match, then return the package ID for that match.
    package_id = 0
    (0..packages.count - 1).each do |i|
      next unless packages[i]['name'] == pkg.name
      package_id = packages[i]['id']
    end
    # List all the package files for that package ID.
    package_files = JSON.parse(Net::HTTP.get(URI("https://gitlab.com/api/v4/projects/26210301/packages/#{package_id}/package_files")))
    # Loop over each result until we find a matching file_sha256 to our binary_sha256.
    (0..package_files.count - 1).each do |i|
      next unless package_files[i]['file_sha256'] == pkg.binary_sha256[ARCH.to_sym]
      return "https://gitlab.com/chromebrew/binaries/-/package_files/#{package_files[i]['id']}/download"
    end
  end

  def self.get_clean_version(pkg_version)
    # Trim kde- suffixes in qt5 packages so nothing else gets confused.
    pkg_version.delete_prefix!('kde-')
    # Delete -py3.12, futureproofed until Python 4
    pkg_version.gsub!(/-py3\.\d{2}/, '')
    # Delete -perl 5.40, futureproofed until Perl 5.100
    pkg_version.gsub!(/-perl5\.\d{2}/, '')
    # Delete -llvm18, futureproofed until llvm 100
    pkg_version.gsub!(/-llvm\d{2}/, '')
    # Delete -glibc2.39, or whatever the system glibc is.
    pkg_version.delete_suffix!("-glibc#{LIBC_VERSION}")
    # Delete git version tags (1.2.4-qnd73k6), avoiding overmatching and hitting things that arent git hashtags.
    pkg_version.gsub!(/-[\w]{7}$/, '')

    return pkg_version
  end
end
