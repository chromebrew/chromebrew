#!/usr/bin/env ruby

require 'open3'
require_relative '../lib/const'
require_relative '../lib/color'
require_relative '../lib/package'
require_relative '../lib/package_utils'

# Add >LOCAL< lib to LOAD_PATH so that packages can be loaded
$LOAD_PATH.unshift File.join(CREW_LIB_PATH, 'lib')

def check_package(pkg, verbose: false)
  puts "Checking #{pkg.name} package ...".yellow if verbose
  unless PackageUtils.installed?(pkg.name)
    puts "Package #{pkg.name} is not installed.".lightred
    puts "Package tests for #{pkg.name} failed.".lightred
    return 1
  end
  if File.exist? "#{CREW_LIB_PATH}/tests/package/#{pkg.name[0]}/#{pkg.name}"
    default_tests = false
    test_stdout, test_stderr, test_status = Open3.capture3("#{CREW_LIB_PATH}/tests/package/#{pkg.name[0]}/#{pkg.name}")
  else
    default_tests = true
    test_stdout, test_stderr, test_status = Open3.capture3("#{CREW_LIB_PATH}/tests/package/default_package_tests #{pkg.name}")
  end
  print test_stdout
  # Check if the tests passed.
  if test_stderr.empty? || test_status.to_s.split.last.to_i.zero?
    puts "Package tests for #{pkg.name} passed.".lightgreen if verbose
    return 0
  elsif default_tests == false
    puts test_stderr
    puts "Package tests for #{pkg.name} failed.".lightred
    return 1
  else
    puts test_stderr
    puts "Default package tests for #{pkg.name} failed.".orange
    return 0
  end
end

if ARGV[0]
  ARGV.each do |name|
    if File.file?(File.join(CREW_PACKAGES_PATH, "#{name}.rb"))
      test_result = check_package(Package.load_package(File.join(CREW_PACKAGES_PATH, "#{name}.rb")), verbose: true)
      exit(1) if test_result.positive?
    else
      puts "Package #{name} not found.".lightred
    end
  end
else
  failed_packages = 0
  Dir["#{CREW_PACKAGES_PATH}/*.rb"].each do |filename|
    failed_packages += check_package(Package.load_package(filename))
  end

  if failed_packages.positive?
    puts "\n#{failed_packages} packages failed package tests.".lightred
    exit(1)
  else
    puts "\nAll packages passed package tests.".lightgreen
  end
end
