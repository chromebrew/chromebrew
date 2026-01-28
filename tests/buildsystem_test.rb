#!/usr/bin/env ruby

require_relative '../lib/const'
require_relative '../lib/color'
require_relative '../lib/package'

# Add >LOCAL< lib to LOAD_PATH so that packages can be loaded
$LOAD_PATH.unshift File.join(CREW_LIB_PATH, 'lib')

def check_buildsystem(pkg_path, verbose: false)
  name = File.basename(pkg_path, '.rb')
  puts "Checking #{name} package ...".yellow if verbose
  # If the buildsystem is invalid, it will almost certainly raise a NameError when we attempt to load it.
  begin
    buildsystem = Package.load_package(pkg_path).superclass.to_s
  rescue NameError => e
    buildsystem = e.name.to_s
  end

  if CREW_VALID_BUILDSYSTEMS.include?(buildsystem)
    puts "Buildsystem test for #{name} passed.".lightgreen if verbose
    return 0
  else
    puts "#{buildsystem} is an invalid buildsystem. Valid buildsystems include #{CREW_VALID_BUILDSYSTEMS.join(', ')}.".lightred
    puts "Buildsystem test for #{name} failed.".lightred
    return 1
  end
end

if ARGV[0]
  ARGV.each do |name|
    if File.file?(File.join(CREW_PACKAGES_PATH, "#{name}.rb"))
      test_result = check_buildsystem(File.join(CREW_PACKAGES_PATH, "#{name}.rb"), verbose: true)
      exit(1) if test_result.positive?
    else
      puts "Package #{name} not found.".lightred
    end
  end
else
  failed_packages = 0
  Dir["#{CREW_PACKAGES_PATH}/*.rb"].each do |filename|
    failed_packages += check_buildsystem(filename)
  end

  if failed_packages.positive?
    puts "\n#{failed_packages} packages failed buildsystem tests.".lightred
    exit(1)
  else
    puts "\nAll packages passed buildsystem tests.".lightgreen
  end
end
