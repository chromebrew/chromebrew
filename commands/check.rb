require 'fileutils'
require_relative '../lib/const'
require_relative '../lib/package'
require_relative '../lib/package_utils'
require_relative '../lib/require_gem'

class Command
  def self.check(name, force, fail_if_check_failure: false)
    # We don't need to check during the Chromebrew install.
    return true if ENV['CREW_INSTALLER_RUNNING']

    local_package = File.join(CREW_LOCAL_REPO_ROOT, 'packages', "#{name}.rb")
    crew_package = File.join(CREW_PACKAGES_PATH, "#{name}.rb")
    local_filelist = File.join(CREW_LOCAL_REPO_ROOT, 'manifest', ARCH, name[0].to_s, "#{name}.filelist")
    crew_filelist_path = File.join(CREW_LIB_PATH, 'manifest', ARCH, name[0].to_s)
    crew_filelist = File.join(crew_filelist_path, "#{name}.filelist")
    local_package_test = File.join(CREW_LOCAL_REPO_ROOT, 'tests', 'package', name[0].to_s, name)
    crew_package_test_path = File.join(CREW_LIB_PATH, 'tests', 'package', name[0].to_s)
    crew_package_test = File.join(crew_package_test_path, name)

    # This pulls the operation from the calling function.
    operation = caller_locations(1, 2)[0].to_s.split[3].split('_')[0].split('#')[1]

    # We return true here in order to exit early but behave as if the check passed, so that other operations can continue.
    unless File.file?(local_package)
      # If the operation is a bare 'crew check', then we don't want to silently skip it.
      puts 'No local package file found, skipping check.'.lightred if operation == 'check'
      return true
    end

    # Use rubocop to sanitize package file, and let errors get flagged.
    if Kernel.system('rubocop --version', %i[out err] => File::NULL)
      puts "Using rubocop to sanitize #{local_package}".yellow
      # The .rubocop.yml file is found in the rubocop-chromebrew gem
      require_gem('rubocop-chromebrew')
      if File.file?(File.join(CREW_LOCAL_REPO_ROOT, '.rubocop.yml'))
        system "rubocop -c #{File.join(CREW_LOCAL_REPO_ROOT, '.rubocop.yml')} -A #{local_package}", exception: true
      else
        puts 'The configuration file for rubocop in .rubocop.yml, from the rubocop-chromebrew gem, was not found.'.lightred
        puts 'To install rubocop-chromebrew, run the following command: '.lightred + "crew #{'re' if PackageUtils.installed?('ruby_rubocop_chromebrew')}install ruby_rubocop_chromebrew".lightblue
      end
    else
      puts "Rubocop is not installed, and thus will not be used to sanitize #{local_package}".lightred
      puts 'To install Rubocop, run the following command: '.lightred + "crew #{'re' if PackageUtils.installed?('ruby_rubocop')}install ruby_rubocop".lightblue
    end

    to_copy_package = force
    to_copy_test = force
    to_copy_filelist = force

    # Prompt to copy the local repo package to crew if the package is not found.
    if !force && File.file?(local_package) && !File.file?(crew_package)
      puts "The crew package #{crew_package} does not exist.".yellow
      to_copy_package = true
    end

    # Prompt to copy the local repo package test to crew if the package test is not found.
    if !force && File.file?(local_package_test) && !File.file?(crew_package_test)
      puts "The crew package test #{crew_package_test} does not exist.".yellow
      to_copy_test = true
    end

    # Prompt to copy the local repo filelist to crew if the filelist is not found.
    if !force && File.file?(local_filelist) && !File.file?(crew_filelist)
      puts "The crew filelist #{crew_filelist} does not exist.".yellow
      to_copy_filelist = true
    end

    # Compare local repo package to the crew repo package and prompt to copy if necessary to prepare for the operation.
    if !force && File.file?(local_package) && File.file?(crew_package) && !FileUtils.identical?(local_package, crew_package)
      puts "#{local_package} does not match the crew package.".yellow
      to_copy_package = true
    end

    # Compare local repo package test to the crew repo package test and prompt to copy if necessary to prepare for the operation.
    if !force && File.file?(local_package_test) && File.file?(crew_package_test) && !FileUtils.identical?(local_package_test, crew_package_test)
      puts "#{local_package_test} does not match the crew package test.".yellow
      to_copy_test = true
    end

    # Compare local repo filelist to the crew filelist and prompt to copy if necessary to prepare for the operation.
    if !force && File.file?(local_filelist) && File.file?(crew_filelist) && !FileUtils.identical?(local_filelist, crew_filelist)
      puts "#{local_filelist} does not match the crew filelist.".yellow
      to_copy_filelist = true
    end

    return false if !force && to_copy_package && !Package.agree_default_yes("\nWould you like to copy #{local_package} to crew and start the #{operation}")

    return false if !force && to_copy_test && !Package.agree_default_yes("\nWould you like to copy #{local_package_test} to crew and start the #{operation}")

    return false if !force && to_copy_filelist && !Package.agree_default_yes("\nWould you like to copy #{local_filelist} to crew and start the #{operation}")

    if to_copy_package && File.file?(local_package)
      FileUtils.copy_file(local_package, crew_package)
      puts "Copied #{local_package} to #{CREW_PACKAGES_PATH}".lightgreen
    end

    if to_copy_test && File.file?(local_package_test)
      FileUtils.mkdir_p crew_package_test_path unless File.directory?(crew_package_test_path)
      FileUtils.copy_file(local_package_test, crew_package_test)
      puts "Copied #{local_package_test} to #{crew_package_test_path}".lightgreen
    end

    if to_copy_filelist && File.file?(local_filelist)
      FileUtils.mkdir_p crew_filelist_path unless File.directory?(crew_filelist_path)
      FileUtils.copy_file(local_filelist, crew_filelist)
      puts "Copied #{local_filelist} to #{crew_filelist_path}".lightgreen
    end

    # Run property and buildsystem tests on the package, and fail if they fail.
    return false unless system "#{CREW_LIB_PATH}/tests/prop_test.rb #{name}"
    return false unless system "#{CREW_LIB_PATH}/tests/buildsystem_test.rb #{name}"
    if ARGV[0] == 'check' && ARGV.include?('--fail_if_check_failure')
      return false unless system("#{CREW_LIB_PATH}/tests/library_test.rb #{name}")
      return false unless system("#{CREW_LIB_PATH}/tests/package_test.rb #{name}")
    end

    # If we're still here every test has passed, so return true.
    return true
  end
end
