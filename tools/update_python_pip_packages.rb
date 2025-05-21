#!/usr/local/bin/ruby
# update_python_pip_packages version 1.4 (for Chromebrew)
# This updates the versions in python pip packages.
#
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in root of cloned chromebrew repo:
# tools/update_python_pip_packages.rb

# Add >LOCAL< lib to LOAD_PATH so that packages can be loaded
$LOAD_PATH.unshift './lib'

require_relative '../lib/color'
require_relative '../lib/const'
require_relative '../lib/package'
require_relative '../lib/package_utils'
require_relative '../lib/require_gem'
require_gem 'concurrent-ruby'
require_gem 'ruby-libversion', 'ruby_libversion'

def check_for_updated_python_packages
  # Some packages should be excluded from the version update check,
  # because some packages have daily updates (awscli) and some packages
  # have broken builds. (ldapdomaindump)
  ignored_packages = %w[ldapdomaindump awscli]

  # Sets the correct pip configuration values if they are not already set.
  pip_config = `pip config list`
  system "pip config --user set global.index-url #{CREW_GITLAB_PKG_REPO}/pypi/simple", %i[err out] => File::NULL unless pip_config.include?("global.index-url='#{CREW_GITLAB_PKG_REPO}/pypi/simple'")
  system 'pip config --user set global.extra-index-url https://pypi.org/simple', %i[err out] => File::NULL unless pip_config.include?("global.extra-index-url='https://pypi.org/simple'")
  system 'pip config --user set global.trusted-host gitlab.com', %i[err out] => File::NULL unless pip_config.include?("global.trusted-host='gitlab.com'")

  # Get a list of all the python/pip packages to check for updates.
  py3_files = Dir['packages/py3_*.rb']
  pip_files = `grep -l "^require 'buildsystems/pip'" packages/*.rb`.split
  relevant_pip_packages = (py3_files + pip_files).uniq!

  # Create a thread pool for parallelization.
  pool = Concurrent::ThreadPoolExecutor.new(
    min_threads: 1,
    max_threads: CREW_NPROC.to_i + 1,
    max_queue: 0, # unbounded work queue
    fallback_policy: :caller_runs
  )

  # Get the total number of files to check, and then the length of that number, so status updates can be formatted.
  total_files_to_check = relevant_pip_packages.length
  numlength = total_files_to_check.to_s.length
  updateable_packages = {}
  packages_without_pypi_versions = []
  relevant_pip_packages.each_with_index do |package, index|
    pool.post do
      pkg = Package.load_package(package)
      pip_name = pkg.name.sub('py3_', '').gsub('_', '-')
      next if ignored_packages.include?(pip_name)
      # The \e[1A\e[K[] is to ensure the concurrency doesn't mess up the order of the printed status updates.
      puts "\e[1A\e[K[#{(index + 1).to_s.rjust(numlength)}/#{total_files_to_check}] Checking pypi for#{' prerelease' if pkg.prerelease?} updates to #{pip_name}...\r".orange
      # Attempt to query pip for the latest version of the package, but if it fails we take note of that and move to the next package.
      begin
        pip_version = `pip index versions #{'--pre' if pkg.prerelease?} #{pip_name} 2>/dev/null`.match(/#{Regexp.escape(pip_name)} \(([^)]+)\)/)[1]
      rescue NoMethodError
        packages_without_pypi_versions << pip_name
        next
      end

      next unless Libversion.version_compare2(PackageUtils.get_clean_version(pkg.version), pip_version) == -1

      updateable_packages[package] = pip_version
    end
  end
  pool.shutdown
  pool.wait_for_termination

  puts "Done checking pypi for updates to #{total_files_to_check} python packages.".orange
  puts "Updated versions were not listed in pypi for: #{packages_without_pypi_versions.join(' ')}".orange

  return updateable_packages
end

def update_package_files(updateable_packages)
  return if updateable_packages.empty?

  updateable_packages.each_pair do |package, new_version|
    pkg = Package.load_package(package)
    puts "Updating #{pkg.name.gsub('_', '-')} from #{pkg.version} to #{new_version}".lightblue
    file = File.read(package)
    file.sub!(PackageUtils.get_clean_version(pkg.version), new_version)
    File.write(package, file)
  end
end

# If being run standalone, also update the package files with the new versions.
update_package_files(check_for_updated_python_packages)
