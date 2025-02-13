#!/usr/bin/env ruby
# update_package_hashes version 1.0 (for Chromebrew)
# This updates the source checksums of updated packages before builds
# are farmed out to the various build runners.
#
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in root of cloned chromebrew repo with a new branch checked out:
# tools/update_package_hashes.rb

require 'English'
require_relative '../lib/color'
require_relative '../lib/const'
require_relative '../lib/package'
require_relative '../lib/require_gem'
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require_gem 'highline'
require_gem 'timeout'

def self.agree_default_yes(message = nil)
  Timeout.timeout(CREW_AGREE_TIMEOUT_SECONDS) do
    return agree_with_default("#{message} (YES/no)?", true, default: 'y')
  end
rescue Timeout::Error
  return true
end

changed_files = `git diff HEAD --name-only`.chomp.split
changed_files_previous_commit = `git diff-tree --no-commit-id --name-only -r $(git rev-parse origin/master)..$(git rev-parse --verify HEAD)`.chomp.split
updated_packages = changed_files.select { |c| c.include?('packages/') }
updated_packages.push(*changed_files_previous_commit.select { |c| c.include?('packages/') })

if updated_packages.empty?
  puts 'No packages need to be updated.'.orange
else
  puts 'These changed packages will be checked to see if they need to update source checksums:'.orange
  updated_packages.uniq!
  updated_packages.each { |p| puts p.sub('packages/', '').sub('.rb', '').to_s.lightblue }
end

crew_update_packages = `CREW_NO_GIT=1 CREW_UNATTENDED=1 crew update | grep "\\[\\""  | jq -r '.[]'`.chomp.split.map(&'packages/'.method(:+)).map { |i| i.concat('.rb') }
updated_packages.push(*crew_update_packages)
updated_packages.uniq!

updated_packages.each do |pkg|
  name = pkg.sub('packages/', '').sub('.rb', '')

  puts "Evaluating #{name} package...".orange
  @pkg_obj = Package.load_package(pkg)

  # Don't check if we need new binaries if the package doesn't already
  # have binaries for this architecture and no_compile_needed is set.
  if !system("grep -q binary_sha256 #{pkg}") && @pkg_obj.no_compile_needed?
    puts "#{name.capitalize} #{@pkg_obj.version} has no binaries and may not need them.".lightgreen
    next pkg
  else
    if @pkg_obj.no_binaries_needed?
      updated_packages.delete(pkg)
      next
    end
    system({ 'CREW_CACHE_ENABLED' => '1' }, "yes | nice -n 20 crew download -s -f #{pkg}")
  end
end
