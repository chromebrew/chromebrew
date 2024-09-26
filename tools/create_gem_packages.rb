#!/usr/bin/env ruby
# create_gem_packages version 1.0 (for Chromebrew)
# This creates ruby gem packages based upon the output of gem's outdated gem list.
#
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in root of cloned chromebrew repo with a new branch checked out:
# tools/create_gem_packages.rb

require 'fileutils'

def create_gem_package(package, current_version = nil)
  description_raw = `gem spec #{package} description`.gsub('--- ', '').split("\n")
  description = if description_raw.length == 1
                  description_raw[0].to_s
                else
                  "#{description_raw.to_a[1..].join("\n").gsub(/\s+/, ' ').strip.split('.').first}."
                end

  # description = `gem spec #{package} description`.split("\n").to_a[1..-1].join("\n").gsub(/\s+/, " ").strip
  # description = `gem spec #{package} description`.split("\n").to_a[1..-1].join("\n").gsub(/\s+/, " ").strip.split('.').first + '.'
  homepage = `gem spec #{package} homepage`.split.last
  # version = `gem spec #{package} version`.split("\n").to_a[1..-1].join.split.last
  version = current_version
  license = `gem spec #{package} license`.split.last

  # File.write File.join('packages', "ruby_" + package.gsub('-', '_') + '.rb'), <<~GEM_PKG_EOF
  new_gem_pkg = <<~GEM_PKG_EOF
    require 'buildsystems/ruby'

    class Ruby_#{package.gsub('-', '_')} < RUBY
      description '#{description}'
      homepage '#{homepage}'
      version "#{version}-\#{CREW_RUBY_VER}"
      license '#{license}'
      compatibility 'all'
      source_url 'SKIP'

      conflicts_ok
      no_compile_needed
    end
  GEM_PKG_EOF
  puts "Package for #{package}:"
  puts new_gem_pkg
  puts
  File.write(File.join('packages', "ruby_#{package.gsub('-', '_')}.rb"), new_gem_pkg)
  FileUtils.chmod 0o644, File.join('packages', "ruby_#{package.gsub('-', '_')}.rb")
end

puts "Checking for gems via 'gem outdated'..."
gems = `gem outdated`.split("\n").reject(&:empty?)
gems.each do |p|
  q = p.split.first
  current_version = p.split[3].delete(')')
  if File.file?(File.join('packages/', "ruby_#{q.gsub('-', '_')}.rb"))
    puts "Package for #{q} exists."
  else
    puts "Package for #{q} does not exist."
    create_gem_package(q, current_version)
  end
end
