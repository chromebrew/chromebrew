#!/usr/local/bin/ruby
# getrealdeps version 2.1 (for Chromebrew)
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
require 'fileutils'

@crew_local_repo_root = `git rev-parse --show-toplevel 2> /dev/null`.chomp
# When invoked from crew, pwd is CREW_DEST_DIR, so @crew_local_repo_root
# is empty.
if @crew_local_repo_root.to_s.empty?
  require_relative '../lib/color'
  require_relative '../lib/const'
else
  require File.join(@crew_local_repo_root, 'lib/color')
  require File.join(@crew_local_repo_root, 'lib/const')
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
  puts "Checking for the runtime dependencies of #{pkg}...".lightblue

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
  pkgdeps = pkgdepsfiles.map { |file| whatprovidesfxn(file, pkg) }.sort.reject { |i| i.include?(pkg) }.map { |i| i.split("\n") }.flatten.uniq

  # Massage the glibc entries in the dependency list.
  pkgdeps = pkgdeps.map { |i| i.gsub(/glibc_build.*/, 'glibc') }.uniq
  pkgdeps = pkgdeps.map { |i| i.gsub(/glibc_lib.*/, 'glibc_lib') }.uniq.map(&:strip).reject(&:empty?)

  # Massage the gcc entries in the dependency list.
  pkgdeps = pkgdeps.map { |i| i.gsub('gcc_build', 'gcc_lib') }.uniq

  # Massage the llvm entries in the dependency list.
  pkgdeps = pkgdeps.map { |i| i.gsub('llvm_build', 'llvm_lib') }.uniq
  pkgdeps = pkgdeps.map { |i| i.gsub(/llvm(\d)+_lib/, 'llvm_lib') }.uniq
  pkgdeps = pkgdeps.map { |i| i.gsub(/llvm(\d)+_dev/, 'llvm_dev') }.uniq

  # Leave early if we didn't find any dependencies.
  return if pkgdeps.empty?

  # Look for missing runtime dependencies, ignoring build and optional deps.
  missingpkgdeps = pkgdeps.reject { |i| File.read("#{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb").include?("depends_on '#{i}'") unless File.read("#{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb").include?("depends_on '#{i}' => :build") || File.read("#{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb").include?("# depends_on '#{i}' # R (optional)") }

  # Special cases where dependencies should not be automatically added:

  dependency_exceptions = Set[
    { name_regex: 'llvm.*_build', exclusion_regex: 'llvm.*_*', comments: 'created from the llvm build package.' },
    { name_regex: '(llvm.*_dev|llvm.*_lib|libclc|openmp)', exclusion_regex: 'llvm.*_build', comments: 'should only be a build dep.' },
    { name_regex: 'llvm.*_lib', exclusion_regex: 'llvm_lib', comments: 'should only be a build dep.' },
    { name_regex: 'gcc_build', exclusion_regex: 'gcc.*_*', comments: 'created from the gcc_build package.' },
    { name_regex: '(gcc_dev|gcc_lib|libssp)', exclusion_regex: 'gcc_build', comments: 'should only be a build dep.' },
    { name_regex: 'gcc_lib', exclusion_regex: 'gcc_lib', comments: 'should only be a build dep.' },
    { name_regex: 'python3', exclusion_regex: '(tcl|tk)', comments: 'optional for i686, which does not have gui libraries.' }
  ]

  dependency_exceptions_pkgs = dependency_exceptions.map { |h| h[:name_regex] }

  dependency_exceptions_pkgs.each do |exception|
    working_exception_pkg = dependency_exceptions.find { |i| i[:name_regex] == exception }
    name_regex = working_exception_pkg[:name_regex]
    exclusion_regex = working_exception_pkg[:exclusion_regex]
    exclusion_comments = working_exception_pkg[:comments]
    next unless /#{name_regex}/.match(pkg)
    puts "#{pkg}: #{exclusion_regex} - #{exclusion_comments}..".orange if pkgdeps.select { |d| /#{exclusion_regex}/.match(d) }.length.positive?
    missingpkgdeps.delete_if { |d| /#{exclusion_regex}/.match(d) }
    pkgdeps.delete_if { |d| /#{exclusion_regex}/.match(d) }
  end

  missingpkgdeps.delete_if { |d| File.read("#{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb").include?("# depends_on '#{d}' # R (optional)") }
  pkgdeps.delete_if { |d| File.read("#{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb").include?("# depends_on '#{d}' # R (optional)") }

  puts "\nPackage #{pkg} has runtime library dependencies on these packages:".lightblue
  pkgdeps.each do |i|
    puts "  depends_on '#{i}' # R".lightgreen
  end

  # Get existing package deps entries so we can add to and sort as
  # necessary.
  pkgdepsblock = []
  pkgdepsblock += File.foreach("#{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb").grep(/  depends_on '|  # depends_on '/)

  unless missingpkgdeps.empty?
    puts "\nPackage file #{pkg}.rb is missing these runtime library dependencies:".orange
    puts "  depends_on '#{missingpkgdeps.join("' # R\n  depends_on '")}' # R".orange

    pkgdepsblock += missingpkgdeps.map { |add_dep| "  depends_on '#{add_dep}' # R" }
  end
  pkgdepsblock.uniq!
  pkgdepsblock = pkgdepsblock.sort_by { |dep| dep.split('depends_on ')[1] }

  puts "\n Adding to or replacing deps block in package..."
  # First remove all dependencies.
  system "sed -i '/  depends_on /d' #{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb"
  system "sed -i '/^  # depends_on /d' #{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb"
  # Now add back our sorted dependencies.
  gawk_cmd = "gawk -i inplace -v dep=\"#{pkgdepsblock.join('QQQQQ')}\" 'FNR==NR{ if (/})/) p=NR; next} 1; FNR==p{ print \"\\n\" dep }' #{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb #{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb"
  system(gawk_cmd)
  # The first added line has two dependencies without a newline
  # separating them.
  system "sed -i 's/RQQQQQ/R\\n/' #{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb"
  system "sed -i 's/QQQQQ//g' #{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb"

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
  # Clean up any blank lines with rubocop.
  system "rubocop --only Layout/EmptyLines -A #{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb"
  FileUtils.cp "#{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb", "#{@crew_local_repo_root}/packages/#{pkg}.rb" unless @crew_local_repo_root.to_s.empty? && lines_to_delete.empty?
  # Leave if there aren't any old runtime dependencies.
  return if lines_to_delete.empty?
  puts "\nPackage file #{pkg}.rb has these outdated runtime library dependencies:".lightpurple
  puts lines_to_delete.keys
  system("gawk -i inplace 'NR != #{lines_to_delete.values.join(' && NR != ')}' #{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb")
  # Clean up any blank lines with rubocop.
  system "rubocop --only Layout/EmptyLines -A #{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb"
  FileUtils.cp "#{CREW_PREFIX}/lib/crew/packages/#{pkg}.rb", "#{@crew_local_repo_root}/packages/#{pkg}.rb" unless @crew_local_repo_root.to_s.empty?
end

ARGV.each do |package|
  main(package.chomp('rb'))
end
