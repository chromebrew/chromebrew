#!/usr/bin/env ruby

# create_default_gems_package version 1.0 (for Chromebrew)
# This creates a default_gems package based upon the output of 'gem list | grep default'.
#
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in root of cloned chromebrew repo with a new branch checked out:
# tools/create_default_gems_package.rb

require 'fileutils'

require_relative '../lib/color'
require_relative '../lib/const'

def create_default_gems_package
  default_gems = `gem list | grep default`.split("\n").map { |g| g.split.first }

  puts 'Default Gems are:'
  puts default_gems
  dependencyblock = ''
  dependencyblock << "#{default_gems.sort.map { |d| "  depends_on 'ruby_#{d.gsub('-', '_')}'" }.join("\n")}"

  default_gems_pkg = <<~GEM_PKG_EOF
    require 'package'

    class Default_gems < Package
      description 'Ruby Default Gem Packages.'
      homepage 'https://github.com/chromebrew/chromebrew'
      version "#{Time.now.utc.strftime('%Y%m%d%H')}-\#{CREW_RUBY_VER}"
      license 'GPL-3+'
      compatibility 'all'
      source_url 'SKIP'

      is_fake

    #{dependencyblock}
    end
  GEM_PKG_EOF
  puts 'Package for default_gems:'.orange
  puts default_gems_pkg.to_s.lightblue
  puts
  File.write(File.join('packages', 'default_gems.rb'), default_gems_pkg)
  system "rubocop -c .rubocop.yml -A  #{File.join('packages', 'default_gems.rb')}"
  FileUtils.chmod 0o644, File.join('packages', 'default_gems.rb')
end

puts "Creating default_gems package from output of 'gem list | grep default'...".orange
create_default_gems_package
