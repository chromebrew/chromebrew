#!/usr/bin/env ruby
# update_python_pip_packages version 1.3 (for Chromebrew)
# This updates the versions in python pip packages.
#
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in root of cloned chromebrew repo:
# tools/update_python_pip_packages.rb

# Add >LOCAL< lib to LOAD_PATH
$LOAD_PATH.unshift '../lib'
require_relative '../lib/color'
require_relative '../lib/const'
require_relative '../lib/require_gem'
require_gem('activesupport', 'active_support/core_ext/object/blank')
require_gem 'concurrent-ruby'

def check_for_updated_python_packages
  # Get a list of all the python/pip packages to check for updates.
  py3_files = Dir['packages/py3_*.rb']
  pip_files = `grep -l "^require 'buildsystems/pip'" packages/*.rb`.chomp.split
  relevant_pip_packages = (py3_files + pip_files).uniq!

  # Sets the correct pip configuration values if they are not already set.
  pip_config = `pip config list`.chomp
  system "pip config --user set global.index-url #{CREW_GITLAB_PKG_REPO}/pypi/simple", %i[err out] => File::NULL unless pip_config.include?("global.index-url='#{CREW_GITLAB_PKG_REPO}/pypi/simple'")
  system 'pip config --user set global.extra-index-url https://pypi.org/simple', %i[err out] => File::NULL unless pip_config.include?("global.extra-index-url='https://pypi.org/simple'")
  system 'pip config --user set global.trusted-host gitlab.com', %i[err out] => File::NULL unless pip_config.include?("global.trusted-host='gitlab.com'")

  pool = Concurrent::ThreadPoolExecutor.new(
    min_threads: 1,
    max_threads: CREW_NPROC.to_i + 1,
    max_queue: 0, # unbounded work queue
    fallback_policy: :caller_runs
  )
  total_files_to_check = relevant_pip_packages.length
  numlength = total_files_to_check.to_s.length
  updateable_packages = {}
  relevant_pip_packages.each_with_index do |package, index|
    pool.post do
      pip_name = package.gsub('.rb', '').sub('py3_', '').gsub('_', '-').gsub('packages/', '')
      prerelease = system("grep -q '^\ \ prerelease' #{package}") ? '--pre' : nil
      # The \e[1A\e[K[] is to ensure the concurrency doesn't mess up the order of the printed status updates.
      puts "\e[1A\e[K[#{(index + 1).to_s.rjust(numlength)}/#{total_files_to_check}] Checking pypi for #{prerelease.blank? ? '' : 'prerelease '}updates to #{pip_name}...\r".orange
      pip_version = `python3 -m pip index versions #{prerelease} #{pip_name} 2>/dev/null | head -n 1 | awk '{print $2}'`.chomp.delete('()')
      next package if pip_version.blank?

      relevant_pip_packages.delete(package)
      pkg_version = `sed -n -e 's/^\ \ version //p' #{package}`.chomp.delete("'").delete('"').gsub('-#{CREW_ICU_VER}', '').gsub('-#{CREW_PY_VER}', '') # rubocop:disable Lint/InterpolationCheck
      next package unless Gem::Version.new(pip_version) > Gem::Version.new(pkg_version)

      updateable_packages[package] = pip_version
    end
  end
  pool.shutdown
  pool.wait_for_termination

  puts "Done checking pypi for updates to #{total_files_to_check} python packages.".orange
  puts "Updated version#{relevant_pip_packages.length > 1 ? 's were' : ' was'} not listed in pypi for: #{relevant_pip_packages.map { |i| i.gsub('.rb', '').sub('ruby_', '').gsub('_', '-').gsub('packages/', '') }.join(' ')}".orange

  return updateable_packages
end

def update_package_files(updateable_packages)
  return if updateable_packages.empty?

  updateable_packages.each_pair do |package, new_version|
    package_name = package.gsub('.rb', '').sub('py3_', '').gsub('_', '-').gsub('packages/', '')
    old_version = `sed -n -e 's/^\ \ version //p' #{package}`.chomp.delete("'").delete('"').gsub('-#{CREW_ICU_VER}', '').gsub('-#{CREW_PY_VER}', '') # rubocop:disable Lint/InterpolationCheck
    puts "Updating #{package_name} from #{old_version} to #{new_version}".lightblue
    if package_name == 'pyicu'
      system "sed -i \"s,^\ \ version\ .*,\ \ version \\\"#{new_version}-\#{CREW_ICU_VER}-\#{CREW_PY_VER}\\\",\" #{package}"
    else
      system "sed -i \"s,^\ \ version\ .*,\ \ version \\\"#{new_version}-\#{CREW_PY_VER}\\\",\" #{package}"
    end
  end
end

# If being run standalone, also update the package files with the new versions.
update_package_files(check_for_updated_python_packages)
