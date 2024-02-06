#!/usr/bin/env ruby
# getrealdeps for Chromebrew version 1.2
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
require 'fileutils'

# Exit quickly if an invalid package name is given.
if ARGV[0].nil? || ARGV[0].empty? || ARGV[0].include?('#')
  puts 'Getrealdeps checks for the dependencies of a package.'
  puts 'Dependencies are added if the package file is missing them.'
  puts 'Usage: getrealdeps.rb <packagename>'
  exit 1
end

pkg = ARGV[0].chomp('.rb')

CREW_PREFIX = ENV['CREW_PREFIX'] || `crew const CREW_PREFIX`.split('=')[1].chomp
CREW_LIB_PREFIX = ENV['CREW_LIB_PREFIX'] || `crew const CREW_LIB_PREFIX`.split('=')[1].chomp

# Package needs to be installed for package filelist to be populated.
unless File.exist? "#{CREW_PREFIX}/etc/crew/meta/#{pkg}.filelist"
  puts "Installing #{pkg} because it is not installed."
  system("yes | crew install #{pkg}")
end

unless File.exist?("#{CREW_PREFIX}/etc/crew/meta/#{pkg}.filelist")
  echo_error "Package #{pkg} either does not exist or does not contain any libraries."
  exit 1
end

# Speed up grep.
ENV['LC_ALL'] = 'C'

# Install grep if a functional local copy does not exist.
if system('grep --version > /dev/null 2>&1')
  GREP = 'grep'
else
  system('crew install grep')
  GREP = "#{CREW_PREFIX}/bin/grep"
end

# Gawk is needed for adding dependencies.
system('crew install gawk') unless system('gawk -W version > /dev/null 2>&1')

# Search for which packages have a needed library in CREW_LIB_PREFIX.
# This is a subset of what crew whatprovides gives.
def whatprovidesfxn(pkgdepslcl, pkg)
  filelcl = if pkgdepslcl.include?(CREW_LIB_PREFIX)
              `#{GREP} --exclude #{pkg}.filelist --exclude={"#{CREW_PREFIX}/etc/crew/meta/*_build.filelist"} "#{pkgdepslcl}$" "#{CREW_PREFIX}"/etc/crew/meta/*.filelist`
            else
              `#{GREP} --exclude #{pkg}.filelist --exclude={"#{CREW_PREFIX}/etc/crew/meta/*_build.filelist"} "^#{CREW_LIB_PREFIX}.*#{pkgdepslcl}$" "#{CREW_PREFIX}"/etc/crew/meta/*.filelist`
            end
  filelcl.gsub(/.filelist.*/, '').gsub(%r{.*/}, '').split("\n").uniq.join("\n").gsub(':', '')
end

# What files does a package provide.
def crewfilesfxn(pkgname)
  File.read("#{CREW_PREFIX}/etc/crew/meta/#{pkgname}.filelist")
end

pkgfiles = crewfilesfxn(pkg).split("\n").uniq

FileUtils.rm_rf("/tmp/deps/#{pkg}")
# Remove files we don't care about, such as man files and non-binaries.
pkgfiles = pkgfiles.reject { |i| !File.file?(i.chomp) || !File.read(i.chomp, 4) == "\x7FELF" || i.include?('.zst') }

# Use readelf to determine library dependencies, as
# this doesn't almost run a program like using ldd would.
pkgdepsfiles = pkgfiles.map do |i|
  system("upx -d #{i} > /dev/null 2>&1") if File.exist?('/.dockerenv')
  FileUtils.mkdir_p("/tmp/deps/#{pkg}/")
  `readelf -d "#{i}" 2>/dev/null | #{GREP} NEEDED | awk '{print $5}' | sed 's/\\[//g' | sed 's/\\]//g' | awk '!x[$0]++' | tee /tmp/deps/#{pkg}/#{File.basename(i)}`
end
pkgdepsfiles = pkgdepsfiles.map do |filedeps|
  filedeps.split("\n")
end.flatten.compact.uniq

# Figure out which Chromebrew packages provide the relevant deps.
pkgdeps = pkgdepsfiles.map do |file|
            whatprovidesfxn(file, pkg)
          end.sort.reject { |i| i.include?(pkg) }.map { |i| i.split("\n")}.flatten.uniq

# Massage the glibc entries in the dependency list.
pkgdeps = pkgdeps.map { |i| i.gsub(/glibc_build.*/, 'glibc') }.uniq
pkgdeps = pkgdeps.map { |i| i.gsub(/glibc_lib.*/, 'glibc_lib') }.uniq.map(&:strip).reject(&:empty?)

missingpkgdeps = pkgdeps.reject do |i|
  File.read("#{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb").include?("depends_on '#{i}'")
end

puts "\nPackage #{pkg} has runtime library dependencies on these packages:"
pkgdeps.each do |i|
  puts "  depends_on '#{i}' # R"
end

if missingpkgdeps.length.positive?
  puts "\nPackage file #{pkg}.rb is missing these runtime library dependencies:"
  missingpkgdeps.each do |i|
    puts "  depends_on '#{i}' # R"
  end
end

# Add missing dependencies to the package.
missingpkgdeps.each do |adddep|
  puts "\n Adding deps: #{adddep}"
  gawk_cmd = if File.foreach("#{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb").grep(/depends_on/).any?
    # This files contains dependencies already, so add new deps after existing dependencies.
               "gawk -i inplace -v dep=\"  depends_on '#{adddep}' # R\" 'FNR==NR{ if (/depends_on/) p=NR; next} 1; FNR==p{ print dep }' #{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb #{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb"
             else
    # This files doesn't contain deps, so just add new deps.
               "gawk -i inplace -v dep=\"  depends_on '#{adddep}' # R\" 'FNR==NR{ if (/})/) p=NR; next} 1; FNR==p{ print \"\\n\" dep }' #{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb #{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb"
             end
  system(gawk_cmd)
end
