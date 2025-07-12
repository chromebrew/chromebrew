#!/usr/local/bin/ruby
# update_ruby_gem_packages version 2.1 (for Chromebrew)
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in root of cloned chromebrew repo:
# tools/update_ruby_gem_packages.rb

# Add >LOCAL< lib to LOAD_PATH
$LOAD_PATH.unshift './lib'

require 'json'
require 'net/http'
require_relative '../lib/color'
require_relative '../lib/const'
require_relative '../lib/convenience_functions'
require_relative '../lib/package'
require_relative '../lib/package_utils'
require_relative '../lib/require_gem'
require_gem 'concurrent-ruby'
require_gem 'ruby-libversion', 'ruby_libversion'

def check_for_updated_ruby_packages
  # Create a thread pool for parallelization.
  pool = Concurrent::ThreadPoolExecutor.new(
    min_threads: 1,
    max_threads: CREW_NPROC.to_i + 1,
    max_queue: 0, # unbounded work queue
    fallback_policy: :caller_runs
  )

  # Currently, the only packages that use the ruby buildsystem are ruby_* packages, so this finds all the packages we need to check.
  relevant_gem_packages = Dir['packages/ruby_*.rb']

  # Get the total number of files to check, and then the length of that number, so status updates can be formatted.
  total_files_to_check = relevant_gem_packages.length
  numlength = total_files_to_check.to_s.length
  updateable_packages = {}
  packages_without_gem_versions = []
  relevant_gem_packages.each_with_index do |package, index|
    pool.post do
      pkg = Package.load_package(package)
      gem_name = pkg.name.sub('ruby_', '')
      # We replace all dashes with underscores in our initial package names, but some gems actually use underscores, so we need special cases.
      # This list was created by looking at what packages were listed as not having updates in rubygems, and then looking up the upstream name for them.
      if %w[
        connection_pool error_highlight lint_roller method_source
        mini_mime multi_xml mutex_m power_assert regexp_parser
        repl_type_completor ruby2_keywords syntax_suggest
      ].include?(gem_name)
        # These gems used underscores originally, so don't replace anything
      elsif gem_name == 'language_server_protocol'
        # These gems have an underscore then a dash, but there's only one, so we hardcode the logic for now.
        gem_name = 'language_server-protocol'
      elsif gem_name == 'unicode_display_width'
        # These gems have a dash then an underscore, but there's only one, so we hardcode the logic for now.
        gem_name = 'unicode-display_width'
      else
        # In the common case, the gem name used only dashes, which we all replaced with underscores.
        gem_name.gsub!('_', '-')
      end

      puts "[#{(index + 1).to_s.rjust(numlength)}/#{total_files_to_check}] Checking rubygems for updates to #{gem_name} in #{package}...".orange

      gem_version = JSON.parse(Net::HTTP.get(URI("https://rubygems.org/api/v1/versions/#{gem_name}/latest.json")))['version']

      if gem_version == 'unknown'
        packages_without_gem_versions << gem_name
        next
      end

      # Any version with a letter is considered a prerelease as per
      # https://docs.ruby-lang.org/en/master/Gem/Version.html#method-i-prerelease-3F
      next if gem_version.match?(/[a-zA-Z]/)

      next unless Libversion.version_compare2(PackageUtils.get_clean_version(pkg.version), gem_version) == -1

      updateable_packages[package] = ruby_gem_version
    end
  end
  pool.shutdown
  pool.wait_for_termination

  puts "Done checking rubygems for updates to #{total_files_to_check} ruby packages.\r".orange
  puts "Updated versions were not listed in rubygems for: #{packages_without_gem_versions.join(' ')}".orange unless packages_without_gem_versions.blank?

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
update_package_files(check_for_updated_ruby_packages)
