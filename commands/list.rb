require 'fileutils'
require 'json'
require_relative '../lib/color'
require_relative '../lib/const'
require_relative '../lib/package'

class Command
  def self.list(available, installed, compatible, incompatible, verbose)
    device_json = JSON.load_file(File.join(CREW_CONFIG_PATH, 'device.json'), symbolize_names: true)
    installed_packages = {}
    device_json[:installed_packages].each do |package|
      installed_packages[package[:name]] = package[:version]
    end

    if available
      Dir["#{CREW_PACKAGES_PATH}/*.rb"].each do |filename|
        pkg_name = File.basename(filename, '.rb')
        next if installed_packages.key?(pkg_name)
        pkg = Package.load_package(filename)
        puts pkg_name if pkg.compatible?
      end
    elsif installed
      if verbose
        installed_packages['======='] = '======='
        installed_packages['Package'] = 'Version'
        first_col_width = installed_packages.keys.max {|a, b| a.size <=> b.size }.size
        installed_packages.sort.to_h.each do |package, version|
          puts "#{package.ljust(first_col_width)}  #{version}".lightgreen
        end
      else
        installed_packages.each_key do |package|
          puts package.lightgreen
        end
      end
    elsif compatible
      Dir["#{CREW_PACKAGES_PATH}/*.rb"].each do |filename|
        pkg_name = File.basename(filename, '.rb')
        pkg = Package.load_package(filename)
        puts pkg_name.lightgreen if pkg.compatible? && installed_packages.key?(pkg_name)
        puts pkg_name if pkg.compatible?
      end
    elsif incompatible
      Dir["#{CREW_PACKAGES_PATH}/*.rb"].each do |filename|
        pkg_name = File.basename(filename, '.rb')
        pkg = Package.load_package(filename)
        puts pkg_name.lightred unless pkg.compatible?
      end
    end
  end
end
