require 'fileutils'
require_relative '../lib/const'
require_relative '../lib/package'
require_relative '../lib/package_utils'
require_relative '../lib/require_gem'

class Command
  def self.check(name, force)
    local_package = File.join(CREW_LOCAL_REPO_ROOT, 'packages', "#{name}.rb")
    crew_package = File.join(CREW_PACKAGES_PATH, "#{name}.rb")

    # We return true here in order to exit early but behave as if the check passed, so that other operations can continue.
    unless File.file?(local_package)
      # If the operation is a bare 'crew check', then we don't want to silently skip it.
      puts 'No local package file found, skipping check.'.lightred if caller_locations(1, 2)[0].to_s.split[3].split('_')[0].split('#')[1].to_s == 'check'
      return true
    end

    # Use rubocop to sanitize package file, and let errors get flagged.
    if Kernel.system('rubocop --version', %i[out err] => File::NULL)
      puts "Using rubocop to sanitize #{local_package}".orange
      # The .rubocop.yml file is found in the rubocop-chromebrew gem
      require_gem('rubocop-chromebrew')
      if File.file?(File.join(CREW_LOCAL_REPO_ROOT, '.rubocop.yml'))
        system "rubocop -c #{File.join(CREW_LOCAL_REPO_ROOT, '.rubocop.yml')} -A #{local_package}", exception: true
      else
        puts 'The configuration file for rubocop in .rubocop.yml, from the rubocop-chromebrew gem, was not found.'.lightred
        puts 'To install rubocop-chromebrew, run the following command: '.lightred + "crew #{PackageUtils.installed?('ruby_rubocop_chromebrew') ? 're' : ''}install ruby_rubocop_chromebrew".lightblue
      end
    else
      puts "Rubocop is not installed, and thus will not be used to sanitize #{local_package}".lightred
      puts 'To install Rubocop, run the following command: '.lightred + "crew #{PackageUtils.installed?('ruby_rubocop') ? 're' : ''}install ruby_rubocop".lightblue
    end

    to_copy = force

    # Prompt to copy the local repo package to crew if the package is not found.
    unless force || File.file?(crew_package)
      puts "The crew package '#{name}' does not exist."
      to_copy = true
    end

    # Compare local repo package to the crew repo package and prompt to copy if necessary to prepare for the operation.
    unless force || (File.file?(crew_package) && FileUtils.identical?(local_package, crew_package))
      puts "#{CREW_LOCAL_REPO_ROOT}/packages/#{name}.rb does not match the crew package."
      to_copy = true
    end

    if to_copy && !force
      # This pulls the operation from the calling function.
      operation = caller_locations(1, 2)[0].to_s.split[3].split('_')[0].split('#')[1]
      if Package.agree_default_yes("\nWould you like to copy #{name}.rb to crew and start the #{operation}")
        to_copy = true
      else
        return false
      end
    end

    if to_copy
      FileUtils.copy_file(local_package, crew_package)
      puts "Copied #{local_package} to #{CREW_PACKAGES_PATH}".lightgreen
    end

    # Run property and buildsystem tests on the package, and fail if they fail.
    return false unless system "#{CREW_LIB_PATH}/tests/prop_test #{name}"
    return false unless system "#{CREW_LIB_PATH}/tests/buildsystem_test #{name}"

    # If we're still here every test has passed, so return true.
    return true
  end
end
