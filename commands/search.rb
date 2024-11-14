require_relative '../lib/const'
require_relative '../lib/package'
require_relative '../lib/package_utils'

class Command
  def self.search(regex_string, verbose)
    Dir["#{CREW_PACKAGES_PATH}/*.rb"].each do |package_path|
      pkg = Package.load_package(package_path)
      # Create a case-insensitive regex from the passed string.
      regex = Regexp.new(regex_string, true)
      next unless regex.match?(File.basename(package_path, '.rb')) || regex.match?(pkg.description)
      # Installed packages have green names, incompatible packages have red, and compatible but not installed have blue.
      if PackageUtils.installed?(pkg.name)
        print pkg.name.lightgreen
      elsif !PackageUtils.compatible?(pkg)
        print pkg.name.lightred
      else
        print pkg.name.lightblue
      end
      puts ": #{pkg.description}".lightblue

      next unless verbose
      puts pkg.homepage
      puts "Version: #{pkg.version}"
      puts "License: #{pkg.license}"
    end
  end
end
