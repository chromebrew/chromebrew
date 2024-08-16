require 'json'
require_relative 'const'
require_relative 'crewlog'

class PackageUtils
  def self.load_json
    return JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'), symbolize_names: true).transform_values! { |val| val.is_a?(String) ? val.to_sym : val }
  end

  def self.save_json(json_object)
    crewlog 'Saving device.json...'
    begin
      File.write File.join(CREW_CONFIG_PATH, 'device.json.tmp'), JSON.pretty_generate(JSON.parse(json_object.to_json))
    rescue StandardError
      puts 'Error writing updated packages json file!'.lightred
      abort
    end

    # Copy over original if the write to the tmp file succeeds.
    FileUtils.cp("#{CREW_CONFIG_PATH}/device.json.tmp", File.join(CREW_CONFIG_PATH, 'device.json')) && FileUtils.rm("#{CREW_CONFIG_PATH}/device.json.tmp")
  end

  def self.installed?(pkg_name)
    return load_json[:installed_packages].any? { |elem| elem[:name] == pkg_name }
  end

  def self.compatible?(pkg)
    return pkg.compatibility.casecmp?('all') || pkg.compatibility.include?(ARCH)
  end

  def self.get_url(pkg, build_from_source: false)
    if !build_from_source && pkg.binary_sha256&.key?(ARCH.to_sym)
      return "https://gitlab.com/api/v4/projects/26210301/packages/generic/#{pkg.name}/#{pkg.version}_#{ARCH}/#{pkg.name}-#{pkg.version}-chromeos-#{ARCH}.#{pkg.binary_compression}"
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
    # Delete -icu75.1, futureproofed until icu 100
    pkg_version.gsub!(/-icu\d{2}\.\d/, '')

    return pkg_version
  end
end
