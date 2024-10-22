#!/usr/bin/env ruby
# getrealdeps version 1.5 (for Chromebrew)
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
require 'fileutils'

crew_local_repo_root = `git rev-parse --show-toplevel 2> /dev/null`.chomp
# When invoked from crew, pwd is CREW_DEST_DIR, so crew_local_repo_root
# is empty.
if crew_local_repo_root.to_s.empty?
  require_relative '../lib/const'
else
  require File.join(crew_local_repo_root, 'lib/const')
end

if ARGV.include?('--use-crew-dest-dir')
  ARGV.delete('--use-crew-dest-dir')
  @opt_use_crew_dest_dir = true
end

# Exit quickly if an invalid package name is given.
if ARGV[0].nil? || ARGV[0].empty? || ARGV[0].include?('#')
  puts 'Getrealdeps checks for the runtime dependencies of a package.'
  puts 'The runtime dependencies are added if the package file is missing them.'
  puts 'Usage: getrealdeps.rb [--use_crew_dest_dir] <packagename>'
  exit 1
end

# Search for which packages have a needed library in CREW_LIB_PREFIX.
# This is a subset of what crew whatprovides gives.
def whatprovidesfxn(pkgdepslcl, pkg)
  filelcl = if pkgdepslcl.include?(CREW_LIB_PREFIX)
              `#{@grep} --exclude #{pkg}.filelist --exclude #{pkgfilelist} --exclude={"#{CREW_PREFIX}/etc/crew/meta/*_build.filelist"} "#{pkgdepslcl}$" "#{CREW_PREFIX}"/etc/crew/meta/*.filelist`
            else
              `#{@grep} --exclude #{pkg}.filelist --exclude #{pkgfilelist} --exclude={"#{CREW_PREFIX}/etc/crew/meta/*_build.filelist"} "^#{CREW_LIB_PREFIX}.*#{pkgdepslcl}$" "#{CREW_PREFIX}"/etc/crew/meta/*.filelist`
            end
  filelcl.gsub(/.filelist.*/, '').gsub(%r{.*/}, '').split("\n").uniq.join("\n").gsub(':', '')
end

def main(pkg)
  puts "Checking for the runtime dependencies of #{pkg}..."

  if @opt_use_crew_dest_dir
    define_singleton_method('pkgfilelist') { File.join(CREW_DEST_DIR, 'filelist') }
    abort('Pkg was not built.') unless File.exist?(pkgfilelist)
  else
    define_singleton_method('pkgfilelist') { "#{CREW_PREFIX}/etc/crew/meta/#{pkg}.filelist" }
    # Package needs to be installed for package filelist to be populated.
    unless File.exist?(pkgfilelist)
      puts "Installing #{pkg} because it is not installed."
      system("yes | crew install #{pkg}")
    end
    abort("Package #{pkg} either does not exist or does not contain any libraries.") unless File.exist?(pkgfilelist)
  end

  # Speed up grep.
  ENV['LC_ALL'] = 'C'

  # Install grep if a functional local copy does not exist.
  if system('grep --version > /dev/null 2>&1')
    @grep = 'grep'
  else
    system('crew install grep')
    @grep = "#{CREW_PREFIX}/bin/grep"
  end

  # Gawk is needed for adding dependencies.
  unless system('gawk -W version > /dev/null 2>&1')
    puts "\nThe inplace replacement functionality of gawk is used to add missing dependencies to package files."
    system('crew install gawk')
  end

  # upx is needed to expand compressed binaries to check for dependencies.
  unless system('upx --version > /dev/null 2>&1')
    puts "\nUpx is needed to expand compressed binaries."
    system('crew install upx')
  end

  # What files does the package provide.
  pkgfiles = File.read(pkgfilelist).split("\n").uniq

  # Look at files in CREW_DEST_DIR instead of assuming the package is
  # normally installed, which lets us avoid installing the package if it
  # was just built.
  pkgfiles.map! { |item| item.prepend(CREW_DEST_DIR) } if @opt_use_crew_dest_dir

  FileUtils.rm_rf("/tmp/deps/#{pkg}")
  # Remove files we don't care about, such as man files and non-binaries.
  pkgfiles = pkgfiles.reject { |i| !File.file?(i.chomp) || File.read(i.chomp, 4) != "\x7FELF" || i.include?('.zst') }

  # Use readelf to determine library dependencies, as
  # this doesn't almost run a program like using ldd would.
  pkgdepsfiles = pkgfiles.map do |i|
    system("upx -d #{i} > /dev/null 2>&1")
    FileUtils.mkdir_p("/tmp/deps/#{pkg}/")
    `readelf -d "#{i}" 2>/dev/null | #{@grep} NEEDED | awk '{print $5}' | sed 's/\\[//g' | sed 's/\\]//g' | awk '!x[$0]++' | tee /tmp/deps/#{pkg}/#{File.basename(i)}`
  end
  pkgdepsfiles = pkgdepsfiles.map do |filedeps|
    filedeps.split("\n")
  end.flatten.compact.uniq

  # Figure out which Chromebrew packages provide the relevant deps.
  pkgdeps = pkgdepsfiles.map do |file|
              whatprovidesfxn(file, pkg)
            end.sort.reject { |i| i.include?(pkg) }.map { |i| i.split("\n") }.flatten.uniq

  # Massage the glibc entries in the dependency list.
  pkgdeps = pkgdeps.map { |i| i.gsub(/glibc_build.*/, 'glibc') }.uniq
  pkgdeps = pkgdeps.map { |i| i.gsub(/glibc_lib.*/, 'glibc_lib') }.uniq.map(&:strip).reject(&:empty?)

  # Leave early if we didn't find any dependencies.
  return if pkgdeps.empty?

  # Look for missing runtime dependencies.
  missingpkgdeps = pkgdeps.reject { |i| File.read("#{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb").include?("depends_on '#{i}'") unless File.read("#{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb").include?("depends_on '#{i}' => :build") }

  puts "\nPackage #{pkg} has runtime library dependencies on these packages:"
  pkgdeps.each do |i|
    puts "  depends_on '#{i}' # R"
  end

  # Leave if we didn't find any missing dependencies.
  return if missingpkgdeps.empty?
  puts "\nPackage file #{pkg}.rb is missing these runtime library dependencies:"
  puts "  depends_on '#{missingpkgdeps.join("' # R\n  depends_on '")}' # R"

  missingpkgdeps.each do |adddep|
    puts "  depends_on '#{adddep}' # R"

    # Add missing dependencies to the package.
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

  # Check for and delete old runtime dependencies.
  # Its unsafe to do this with other dependencies, because the packager might know something we don't.
  lines_to_delete = {}
  File.readlines("#{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb").each_with_index do |line, line_number|
    # Find all the explicitly marked runtime dependencies.
    dep = line.match(/  depends_on '(.*)' # R/)
    # Basically just a nil check, but this way we avoid matching twice.
    next unless dep
    # Skip unless the runtime dependency in the package does not match the runtime dependencies we've found.
    next unless pkgdeps.none?(dep[1])
    # Skip if we're dealing with a glibc, glibc_lib or gcc_lib dependency-- these are architecture dependent sometimes?
    next if %w[glibc glibc_lib gcc_lib].include?(dep[1])
    # Record the line content as the key and the line number (incremented by one because the index starts at 0) as the value.
    lines_to_delete[line] = line_number + 1
  end
  # Leave if there aren't any old runtime dependencies.
  return if lines_to_delete.empty?
  puts "\nPackage file #{pkg}.rb has these outdated runtime library dependencies:"
  puts lines_to_delete.keys
  system("gawk -i inplace 'NR != #{lines_to_delete.values.join(' && NR != ')}' #{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb")
end

ARGV.each do |package|
  main(package.chomp('rb'))
end
