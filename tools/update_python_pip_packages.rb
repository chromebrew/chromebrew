#!/usr/bin/env ruby
# update_python_pip_packages version 1.1 (for Chromebrew)
# This updates the versions in python pip packages.
#
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in root of cloned chromebrew repo:
# tools/update_python_pip_packages.rb
require_relative '../lib/color'
require_relative '../lib/const'
def require_gem(gem_name_and_require = nil, require_override = nil)
  # Allow only loading gems when needed.
  return if gem_name_and_require.nil?

  gem_name = gem_name_and_require.split('/')[0]
  begin
    gem gem_name
  rescue LoadError
    puts " -> install #{gem_name} gem".orange
    Gem.install(gem_name)
    gem gem_name
  end
  requires = if require_override.nil?
               gem_name_and_require.split('/')[1].nil? ? gem_name_and_require.split('/')[0] : gem_name_and_require
             else
               require_override
             end
  require requires
end
require_gem('activesupport', 'active_support/core_ext/object/blank')
require_gem 'concurrent-ruby'

py3_files = Dir['packages/py3_*.rb']
pip_files = `grep -l "^require 'buildsystems/pip'" packages/*.rb`.chomp.split
relevant_pip_packages = (py3_files + pip_files).uniq!

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
relevant_pip_packages.each_with_index do |package, index|
  pool.post do
    pip_name = package.gsub('.rb', '').sub('py3_', '').gsub('_', '-').gsub('packages/', '')
    prerelease = system("grep -q '^\ \ prerelease' #{package}") ? '--pre' : nil
    puts "\e[1A\e[K[#{(index + 1).to_s.rjust(numlength)}/#{total_files_to_check}] Checking pypi for #{prerelease.blank? ? '' : 'prerelease '}updates to #{pip_name}...\r".orange
    pip_version = `python -m pip index versions #{prerelease} #{pip_name} 2>/dev/null | head -n 1 | awk '{print $2}'`.chomp.delete('()')
    next package if pip_version.blank?

    relevant_pip_packages.delete(package)
    pkg_version = `sed -n -e 's/^\ \ version //p' #{package}`.chomp.delete("'").delete('"').gsub('-#{CREW_ICU_VER}', '').gsub('-#{CREW_PY_VER}', '')
    next package unless Gem::Version.new(pip_version) > Gem::Version.new(pkg_version)

    puts "\e[1B\e[KUpdating #{pip_name} from #{pkg_version} to #{pip_version}\e[1A".lightblue
    if pip_name == 'pyicu'
      system "sed -i \"s,^\ \ version\ .*,\ \ version \\\"#{pip_version}-\#{CREW_ICU_VER}-\#{CREW_PY_VER}\\\",\" #{package}"
    else
      system "sed -i \"s,^\ \ version\ .*,\ \ version \\\"#{pip_version}-\#{CREW_PY_VER}\\\",\" #{package}"
    end
  end
end
pool.shutdown
pool.wait_for_termination
puts "Done checking pypi for updates to #{total_files_to_check} python packages.".orange
return if relevant_pip_packages.blank?

puts "Updated version#{relevant_pip_packages.length > 1 ? 's were' : ' was'} not listed in pypi for: #{relevant_pip_packages.map { |i| i.gsub('.rb', '').sub('ruby_', '').gsub('_', '-').gsub('packages/', '') }.join(' ')}".orange
