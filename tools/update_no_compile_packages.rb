#!/usr/bin/env ruby
# update_no_compile_packages version 1.0 (for Chromebrew)
# This checks if packages with 'no_compile_needed' require updates.
#
# Author: Ed Reel (uberhacker) edreel at gmail dot com
# Usage in root of cloned chromebrew repo with a new branch checked out:
# tools/update_no_compile_packages.rb

require 'English'
require_relative '../lib/color'
require_relative '../lib/const'
require_relative '../lib/package'
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

abort 'Unable to locate packages. Please run from the repository root directory.'.lightred unless Dir.exist?('packages')

puts "Setting the CREW_AGREE_TIMEOUT_SECONDS environment variable to less than the default of #{CREW_AGREE_TIMEOUT_SECONDS} may speed this up...".orange if ENV['CREW_AGREE_TIMEOUT_SECONDS'].nil?

def self.agree_default_yes(message = nil)
  Timeout.timeout(CREW_AGREE_TIMEOUT_SECONDS) do
    return agree_with_default("#{message} (YES/no)?", true, default: 'y')
  end
rescue Timeout::Error
  return true
end

changed_files = `git diff HEAD --name-only`.chomp.split
updated_packages = changed_files.select { |c| c.include?('packages/') }
changed_files_previous_commit = `git diff-tree --no-commit-id --name-only -r $(git rev-parse origin/master)..$(git rev-parse --verify HEAD)`.chomp.split
unless changed_files_previous_commit.empty?
  updated_previous_packages = changed_files_previous_commit.select { |c| c.include?('packages/') }
  updated_packages.push(*updated_previous_packages)
end

abort 'No packages need to be updated.'.orange if updated_packages.empty?

puts 'Changed packages will be checked to see if they need updated.'.orange
updated_packages.each do |pkg|
  @pkg_obj = Package.load_package(pkg)
  updated_packages.delete(pkg) unless @pkg_obj.no_compile_needed?
end

abort 'No packages need to be updated.'.orange if updated_packages.empty?

updated_packages.uniq!

updated_packages.each do |pkg|
  name = pkg.sub('packages/', '').sub('.rb', '')
  puts name.to_s.lightblue

  puts "Evaluating #{name} package...".orange
  @pkg_obj = Package.load_package(pkg)

  system("crew install -f #{name}")
  abort "#{name} install failed!".lightred unless $CHILD_STATUS.success?
end
