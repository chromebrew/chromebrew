#!/usr/bin/env ruby

require_relative '../lib/const'
require_relative '../lib/color'
require_relative '../lib/package'

# Add >LOCAL< lib to LOAD_PATH so that packages can be loaded
$LOAD_PATH.unshift File.join(CREW_LIB_PATH, 'lib')

def check_properties(pkg, verbose: false)
  puts "Checking #{pkg.name} package ...".yellow if verbose
  # List out all the possible failure states
  empty_description = pkg.description.to_s.empty?
  empty_homepage = pkg.homepage.to_s.empty?
  empty_version = pkg.version.to_s.empty?
  empty_license = pkg.license.to_s.empty?
  empty_compatibility = pkg.compatibility.to_s.empty?
  # Certain fake packages set up to act as aliases (we should probably move on from these) do not have source_url values.
  empty_source_url = pkg.source_url.to_s.empty? && !pkg.is_fake?
  both_binary_compression_and_no_compile_needed = pkg.no_compile_needed? && !pkg.binary_compression.to_s.empty?
  non_skip_source_url_and_no_source_build = pkg.no_source_build? && !pkg.source_url.eql?('SKIP')

  # Tell the user what specific test fiailed.
  puts "#{pkg.name} is missing a description.".lightred if empty_description
  puts "#{pkg.name} is missing a homepage.".lightred if empty_homepage
  puts "#{pkg.name} is missing a version.".lightred if empty_version
  puts "#{pkg.name} is missing a license.".lightred if empty_license
  puts "#{pkg.name} is missing a compatibility.".lightred if empty_compatibility
  puts "#{pkg.name} is missing a source_url.".lightred if empty_source_url
  puts "#{pkg.name} has a binary_compression value and a no_compile_needed value." if both_binary_compression_and_no_compile_needed
  puts "#{pkg.name} has a non-SKIP source_url and a no_source_build value." if non_skip_source_url_and_no_source_build

  # Check that if the tests passed.
  if empty_description || empty_homepage || empty_version || empty_license || empty_compatibility || empty_source_url || both_binary_compression_and_no_compile_needed || non_skip_source_url_and_no_source_build
    puts "Property tests for #{pkg.name} failed.".lightred
    return 1
  else
    puts "Property tests for #{pkg.name} passed.".lightgreen if verbose
    return 0
  end
end

if ARGV[0]
  ARGV.each do |name|
    if File.file?(File.join(CREW_PACKAGES_PATH, "#{name}.rb"))
      test_result = check_properties(Package.load_package(File.join(CREW_PACKAGES_PATH, "#{name}.rb")), verbose: true)
      exit(1) if test_result.positive?
    else
      puts "Package #{name} not found.".lightred
    end
  end
else
  failed_packages = 0
  Dir["#{CREW_PACKAGES_PATH}/*.rb"].each do |filename|
    failed_packages += check_properties(Package.load_package(filename))
  end

  if failed_packages.positive?
    puts "\n#{failed_packages} packages failed property tests.".lightred
    exit(1)
  else
    puts "\nAll packages passed property tests.".lightgreen
  end
end
