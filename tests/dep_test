#!/usr/bin/env ruby

require_relative '../lib/const'
require_relative '../lib/color'
require_relative '../lib/package'

# Add >LOCAL< lib to LOAD_PATH so that packages can be loaded
$LOAD_PATH.unshift File.join(CREW_LIB_PATH, 'lib')

def check_for_removed_dependencies(pkg, verbose: false)
  pkg.get_deps_list
  puts "Removed dependency test for #{pkg.name} passed.".lightgreen if verbose
  return 0
rescue Errno::ENOENT => e
  puts "#{pkg.name} depends on removed package #{e.to_s[%r{/packages/(\w+)\.rb}, 1]}".lightred
  puts "Removed dependency test for #{pkg.name} failed.".lightred
  return 1
end

if ARGV[0]
  ARGV.each do |name|
    if File.file?(File.join(CREW_PACKAGES_PATH, "#{name}.rb"))
      test_result = check_for_removed_dependencies(Package.load_package(File.join(CREW_PACKAGES_PATH, "#{name}.rb")), verbose: true)
      exit(1) if test_result.positive?
    else
      puts "Package #{name} not found.".lightred
    end
  end
else
  failed_packages = 0
  Dir["#{CREW_PACKAGES_PATH}/*.rb"].each do |filename|
    failed_packages += check_for_removed_dependencies(Package.load_package(filename))
  end

  if failed_packages.positive?
    puts "\n#{failed_packages} packages failed dependency tests.".lightred
    exit(1)
  else
    puts "\nAll packages passed dependency tests.".lightgreen
  end
end
