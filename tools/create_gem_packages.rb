#!/usr/bin/env ruby

# create_gem_packages version 1.4 (for Chromebrew)
# This creates ruby gem packages based upon the default and bundled gems
# listed at https://stdgems.org/
# OR from gem names passed in as arguments.
#
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in root of cloned chromebrew repo with a new branch checked out:
# tools/create_gem_packages.rb <gem name> ...

require 'fileutils'
require 'json'
require_relative '../lib/color'
require_relative '../lib/const'
require_relative '../lib/require_gem'

require_gem('httpparty')

def check_gem_binary_build_needed(ruby_gem_name = nil, ruby_gem_version = nil)
  puts "Checking to see if gem compile for #{ruby_gem_name} is needed..."
  @extract_dir = "#{ruby_gem_name}.#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.dir"
  FileUtils.mkdir_p File.join(CREW_BREW_DIR, @extract_dir)
  Dir.chdir(File.join(CREW_BREW_DIR, @extract_dir)) do
    # Need to check if the gem has extensions. If it does, we need
    # either a compiler or a pre-compiled binary gem.
    system "gem fetch #{ruby_gem_name} --platform=ruby --version=#{ruby_gem_version}"
    system "gem unpack #{ruby_gem_name}-#{ruby_gem_version}.gem"
    @build_needed = system "grep -q -r spec.extensions  #{ruby_gem_name}-#{ruby_gem_version}/*.gemspec", %i[out err] => File::NULL
  end
  FileUtils.rm_rf File.join(CREW_BREW_DIR, @extract_dir)
  return @build_needed
end

def check_gem_deps(package)
  # 'gem dependency <package> -b' (including remote) appears to hang
  # when the package is not locally installed.
  puts "Installing #{package}".orange
  system "gem install -N #{package} --conservative"
  puts "Checking #{package} for dependencies...".orange
  return `gem dependency #{package} | grep -v 'development)'`.split("\n").reject(&:empty?).map { |g| g.split.first }.reject { |x| x == 'Gem' }.sort
end

def check_gem_pkg_deps(package)
  dependencies = check_gem_deps(package)
  return if dependencies.empty?

  pkg_file_path = File.join('packages/', "ruby_#{package.gsub('-', '_')}.rb")
  abort "#{pkg_file_path} is missing.".lightred unless File.file?(pkg_file_path)

  @gems_to_add.push(*dependencies).sort!
  @gems_to_add.uniq!
  puts "Dependencies for #{package} are:"
  puts dependencies
  dependencies_to_add = dependencies.dup
  file = File.read(pkg_file_path)
  dependencies.each do |dep|
    ruby_add_dep = "ruby_#{dep.gsub('-', '_')}"
    dep_re = /^\s*depends_on '#{ruby_add_dep}'/
    dependencies_to_add.delete(dep) if file.match(dep_re)
  end
  if dependencies_to_add.empty?
    puts "All dependencies are already in the package file for #{package}.".lightgreen
    return
  end
  # dependencyblock = ''
  # dependencyblock << "\n#{dependencies_to_add.sort.map { |d| "  depends_on 'ruby_#{d.gsub('-', '_')}' # R" }.join("\n")}\n" unless dependencies.empty?

  dependencies_to_add.each do |adddep|
    ruby_add_dep = "ruby_#{adddep.gsub('-', '_')}"
    # Add missing dependencies to the package.
    puts "\n Adding deps: #{ruby_add_dep}"
    dep_re = /^\s*depends_on /
    gawk_cmd = if file.match(dep_re)
                 # This files contains dependencies already, so add new deps after existing dependencies.
                 "gawk -i inplace -v dep=\"  depends_on '#{ruby_add_dep}' # R\" 'FNR==NR{ if (/depends_on/) p=NR; next} 1; FNR==p{ print dep }' #{pkg_file_path} #{pkg_file_path}"
               else
                 # This files doesn't contain deps, so just add new deps.
                 "gawk -i inplace -v dep=\"  depends_on '#{ruby_add_dep}' # R\" 'FNR==NR{ if (/})/) p=NR; next} 1; FNR==p{ print \"\\n\" dep }' #{pkg_file_path} #{pkg_file_path}"
               end
    system(gawk_cmd)
  end
  system "rubocop -c .rubocop.yml -A #{pkg_file_path}"
end

def create_gem_package(package)
  description_raw = `gem spec #{package} description -b`.gsub('--- ', '').split("\n").reject(&:empty?)
  description = if description_raw.length == 1
                  "#{description_raw[0].to_s.strip.split('.').first}."
                else
                  "#{description_raw.join("\n").gsub(/\s+/, ' ').strip.split('.').first}."
                end

  homepage = `gem spec #{package} homepage -b`.split.last
  version = `gem spec #{package} version -b`.split("\n").to_a[1..].join.split.last
  license = `gem spec #{package} license -b`.split.last

  dependencies = check_gem_deps(package)
  dependencyblock = ''
  unless dependencies.empty?
    puts "Dependencies for #{package} are:"
    puts dependencies
    dependencyblock << "\n#{dependencies.sort.map { |d| "  depends_on 'ruby_#{d.gsub('-', '_')}' # R" }.join("\n")}\n"
    @gems_to_add.push(*dependencies).sort!
    @gems_to_add.uniq!
  end

  new_gem_pkg = <<~GEM_PKG_EOF
    require 'buildsystems/ruby'

    class Ruby_#{package.gsub('-', '_')} < RUBY
      description "#{description}"
      homepage '#{homepage}'
      version "#{version}-\#{CREW_RUBY_VER}"
      license '#{license}'
      compatibility 'all'
      source_url 'SKIP'
    #{dependencyblock}
      conflicts_ok
      #{check_gem_binary_build_needed(package, version) ? 'gem_compile_needed' : 'no_compile_needed'}
    end
  GEM_PKG_EOF
  puts "Package for #{package}:".orange
  puts new_gem_pkg.to_s.lightblue
  puts
  File.write(File.join('packages', "ruby_#{package.gsub('-', '_')}.rb"), new_gem_pkg)
  system "rubocop -c .rubocop.yml -A  #{File.join('packages', "ruby_#{package.gsub('-', '_')}.rb")}"
  FileUtils.chmod 0o644, File.join('packages', "ruby_#{package.gsub('-', '_')}.rb")
end

@gems_to_add = []
# Allow gems to be passed in as arguments to this script.
input_array = ARGV
if input_array.length.positive?
  puts 'Only trying to create gem packages for:'.orange
  puts input_array.to_s.orange
  @gems_to_add.push(*input_array)
else
  puts 'Checking for default gems from https://stdgems.org/default_gems.json'
  default_gem_json = JSON.parse(HTTParty.get('https://stdgems.org/default_gems.json').body)
  default_gems = default_gem_json['gems'].map { |i| i['gem'] }
  default_gems.delete('win32ole')

  puts 'Checking for bundled gems from https://stdgems.org/bundled_gems.json'
  bundled_gem_json = JSON.parse(HTTParty.get('https://stdgems.org/bundled_gems.json').body)
  bundled_gems = bundled_gem_json['gems'].map { |i| i['gem'] }

  puts "Checking for updated gems via 'gem outdated'...".orange
  outdated_gems = `gem outdated`.split("\n").reject(&:empty?).map { |g| g.split.first }
  @gems_to_add.push(*default_gems)
  @gems_to_add.push(*bundled_gems)
  @gems_to_add.push(*outdated_gems)
end
@gems_to_add.sort!
@gems_to_add.uniq!
if @gems_to_add.empty?
  abort('No gems to add!'.lightblue)
else
  puts 'Gems_to_add:'.lightpurple
  puts @gems_to_add.to_s.lightpurple
end
until @gems_to_add.empty?
  @gems_to_add.each do |p|
    if File.file?(File.join('packages/', "ruby_#{p.gsub('-', '_')}.rb"))
      puts "Package file for #{p} exists.".orange
      check_gem_pkg_deps(p)
    else
      puts "Package file for #{p} does not exist. Creating one...".lightblue
      create_gem_package(p)
    end
    @gems_to_add.delete(p)
    puts '@gems_to_add is now:'.orange
    puts @gems_to_add.to_s.orange
  end
end
