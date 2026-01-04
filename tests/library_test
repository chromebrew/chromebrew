#!/usr/bin/env ruby

require_relative '../lib/const'
require_relative '../lib/color'
require_relative '../lib/package'

# Add >LOCAL< lib to LOAD_PATH so that packages can be loaded
$LOAD_PATH.unshift File.join(CREW_LIB_PATH, 'lib')

def check_libraries(pkg_path, verbose: false)
  name = File.basename(pkg_path, '.rb')
  puts "Checking #{name} package ...".yellow if verbose
  # If the package is invalid, it will almost certainly raise a NameError when we attempt to load it.
  begin
    Package.load_package(pkg_path)
  rescue NameError => e
    e.name.to_s
  end

  filelist = "#{CREW_LIB_PATH}/manifest/#{ARCH}/#{name[0]}/#{name}.filelist"
  unless File.exist?(filelist)
    puts "The manifest #{filelist} does not exist.".lightred
    puts "Library test for #{name} failed.".lightred
    return 1
  end

  libraries = `grep -E "^#{CREW_PREFIX}/lib" "#{filelist}" | grep -vE "^#{CREW_PREFIX}/libexec/" | grep -vE "^#{CREW_PREFIX}/lib/perl" | grep -vE "^#{CREW_PREFIX}/lib/python"`.chomp
  if libraries.empty?
    puts "Library test for #{name} passed.".lightgreen if verbose
    return 0
  else
    valid_libraries = `grep -E "^#{CREW_LIB_PREFIX}/" "#{filelist}" | grep -vE "^#{CREW_PREFIX}/libexec/" | grep -vE "^#{CREW_PREFIX}/lib/perl" | grep -vE "^#{CREW_PREFIX}/lib/python"`.chomp
    if valid_libraries.empty?
      puts 'Invalid libraries:'.lightred
      puts libraries.lightred
      puts "Library test for #{name} failed.".lightred
      return 1
    elsif libraries != valid_libraries
      libraries_array = libraries.split("\n")
      valid_libraries_array = valid_libraries.split("\n")
      invalid_libraries_array = libraries_array - valid_libraries_array
      invalid_libraries = invalid_libraries_array.join("\n")
      puts 'Invalid libraries:'.lightred
      puts invalid_libraries.lightred
      puts "Library test for #{name} failed.".lightred
      return 1
    else
      puts "Library test for #{name} passed.".lightgreen if verbose
      return 0
    end
  end
end

if ARGV[0]
  ARGV.each do |name|
    if File.file?(File.join(CREW_PACKAGES_PATH, "#{name}.rb"))
      test_result = check_libraries(File.join(CREW_PACKAGES_PATH, "#{name}.rb"), verbose: true)
      exit(1) if test_result.positive?
    else
      puts "Package #{name} not found.".lightred
    end
  end
else
  failed_packages = 0
  Dir["#{CREW_PACKAGES_PATH}/*.rb"].each do |filename|
    failed_packages += check_libraries(filename)
  end

  if failed_packages.positive?
    puts "\n#{failed_packages} packages failed library tests.".lightred
    exit(1)
  else
    puts "\nAll packages passed library tests.".lightgreen
  end
end
