#!/usr/bin/env ruby
# update_ruby_gem_packages version 1.9 (for Chromebrew)
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in root of cloned chromebrew repo:
# tools/update_ruby_gem_packages.rb

# Add >LOCAL< lib to LOAD_PATH
$LOAD_PATH.unshift '../lib'
require_relative '../lib/color'
require_relative '../lib/gem_compact_index_client'
require_relative '../lib/require_gem'
CREW_NPROC = `nproc`.chomp
CREW_RUBY_VER = "ruby#{RUBY_VERSION.slice(/(?:.*(?=\.))/)}"
CREW_VERBOSE = false

require_gem('activesupport', 'active_support/core_ext/object/blank')
require_gem 'concurrent-ruby'

gems ||= BasicCompactIndexClient.new.gems

pool = Concurrent::ThreadPoolExecutor.new(
  min_threads: 1,
  max_threads: CREW_NPROC.to_i + 1,
  max_queue: 0, # unbounded work queue
  fallback_policy: :caller_runs
)
relevant_gem_packages = Dir['packages/ruby_*.rb']
total_files_to_check = relevant_gem_packages.length
numlength = total_files_to_check.to_s.length
relevant_gem_packages.each_with_index do |package, index|
  pool.post do
    untested_package_name = package.gsub(%r{^packages/ruby_}, '').gsub(/.rb$/, '')
    gem_test = gems.grep(/#{"^#{untested_package_name}\\s.*$"}/).last.blank? ? gems.grep(/#{"^\(#{passed_name.gsub(/^ruby_/, '').gsub('_', ')*.(')}\\s\).*$"}/).last : gems.grep(/#{"^#{untested_package_name}\\s.*$"}/).last
    abort "Cannot find #{passed_name} gem to install.".lightred if gem_test.blank?
    gem_test_name = gem_test.split.first
    puts "#{untested_package_name} versions for #{gem_test_name} are #{gem_test.split[1].split(',')}" if CREW_VERBOSE
    gem_test_versions = gem_test.split[1].split(',')
    # Any version with a letter is considered a prerelease as per
    # https://github.com/rubygems/rubygems/blob/b5798efd348935634d4e0e2b846d4f455582db48/lib/rubygems/version.rb#L305
    gem_test_versions.delete_if { |i| i.match?(/[a-zA-Z]/) }
    gem_test_version = gem_test_versions.max
    puts "#{untested_package_name} is #{gem_test_name} version #{gem_test_version}".lightpurple if CREW_VERBOSE
    gem_name = gem_test_name.blank? ? Gem::SpecFetcher.fetcher.suggest_gems_from_name(untested_package_name).first : gem_test_name
    gem_version = gem_test_name.blank? ? Gem.latest_version_for(untested_package_name).to_s : gem_test_version

    puts "[#{(index + 1).to_s.rjust(numlength)}/#{total_files_to_check}] Checking rubygems for updates to #{gem_name} in #{package}...".orange
    pkg_version = `sed -n -e 's/^\ \ version //p' #{package}`.chomp.delete("'").delete('"').gsub(/-\#{CREW_RUBY_VER}/, '').split('-').first
    next package if gem_version.blank?
    if Gem::Version.new(gem_version) > Gem::Version.new(pkg_version)
      puts "Updating #{gem_name} from #{pkg_version} to #{gem_version}".lightblue
      system "sed -i \"s,^\ \ version\ .*,\ \ version \\\"#{gem_version}-\#{CREW_RUBY_VER}\\\",\" #{package}"
    end
    relevant_gem_packages.delete(package)
  end
end
pool.shutdown
pool.wait_for_termination
puts "Done checking for updates to #{total_files_to_check} ruby gems.\r".orange
return if relevant_gem_packages.blank?

puts "Updated version#{relevant_gem_packages.length > 1 ? 's were' : ' was'} could not be found for: #{relevant_gem_packages.map { |i| i.gsub('.rb', '').sub('ruby_', '').gsub('_', '-').gsub('packages/', '') }.join(' ')}".orange
