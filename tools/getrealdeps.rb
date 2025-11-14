#!/usr/local/bin/ruby
# getrealdeps version 2.4 (for Chromebrew)
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
require 'fileutils'

crew_local_repo_root = `git rev-parse --show-toplevel 2> /dev/null`.chomp
# When invoked from crew, pwd is CREW_DEST_DIR, so crew_local_repo_root
# is empty.
if crew_local_repo_root.to_s.empty?
  require_relative '../lib/color'
  require_relative '../lib/const'
  require_relative '../lib/package'
  require_relative '../lib/package_utils'
  $LOAD_PATH.unshift File.expand_path('../lib', __dir__)
else
  require File.join(crew_local_repo_root, 'lib/color')
  require File.join(crew_local_repo_root, 'lib/const')
  require File.join(crew_local_repo_root, 'lib/package')
  require File.join(crew_local_repo_root, 'lib/package_utils')
  $LOAD_PATH.unshift File.expand_path(File.join(crew_local_repo_root, 'lib'), __dir__)
end

if ARGV.include?('--use-crew-dest-dir')
  ARGV.delete('--use-crew-dest-dir')
  @opt_use_crew_dest_dir = true
end

# If we're running as a script, exit quickly if an invalid package name is given.
if __FILE__ == $PROGRAM_NAME && (ARGV[0].nil? || ARGV[0].empty? || ARGV[0].include?('#'))
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

# Write the missing dependencies to the package file.
def write_deps(pkg_file, pkgdeps, pkg)
  # pkg is not pkg.name in this function.
  # e.g., pkg is Package::Py3_pyyaml
  # Add special deps for perl, pip, python, and ruby gem packages.
  case pkg.superclass.to_s
  when 'PERL'
    pkgdeps << 'perl'
  when 'Pip', 'Python'
    pkgdeps << 'python3'
  when 'RUBY'
    pkgdeps << 'ruby'
  end

  pkgdeps.uniq!

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

  dependency_exceptions.each do |exception|
    # We're only interested if this package matches the name regex.
    next unless /#{exception[:name_regex]}/.match?(pkg.name)
    # This lets us check if any dependencies were excluded.
    pkgdeps_length = pkgdeps.length
    # Delete any dependencies that should be excluded.
    pkgdeps.delete_if { /#{exception[:exclusion_regex]}/.match?(it) }
    # If any dependencies were excluded, explain why.
    puts "#{pkg.name}: #{exception[:exclusion_regex]} - #{exception[:comments]}..".orange if pkgdeps_length != pkgdeps.length
  end

  puts "\nPackage #{pkg.name} has runtime library dependencies on these packages:".lightblue
  pkgdeps.each do |i|
    puts "  depends_on '#{i}' # R".lightgreen
  end

  # Look for runtime dependencies that aren't already provided by the package.
  missingpkgdeps = pkgdeps.reject { File.read(pkg_file).include?("depends_on '#{it}'") unless File.read(pkg_file).include?("depends_on '#{it}' => :build") }

  unless missingpkgdeps.empty?
    puts "\nPackage file #{pkg_file} is missing these runtime library dependencies:".orange
    puts "  depends_on '#{missingpkgdeps.join("' # R\n  depends_on '")}' # R".orange
  end

  # Read the package file into an array of lines.
  pkg_file_lines = File.readlines(pkg_file)

  # Get existing package deps entries so we can add to and sort as necessary.
  pkgdepsblock = pkg_file_lines.filter { it.include?("depends_on '") }

  # Add any missing runtime dependencies to the block of dependencies.
  pkgdepsblock += missingpkgdeps.map { "  depends_on '#{it}' # R" }

  # These deps are sometimes architecture dependent or should not be removed for other reasons.
  privileged_deps = %w[glibc glibc_lib gcc_lib perl python3 ruby]

  # Check for and delete old runtime dependencies.
  # Its unsafe to do this with other dependencies, because the packager might know something we don't.
  pkgdepsblock.delete_if { |line| line.match(/  depends_on '(.*)' # R/) { |matchdata| pkgdeps.none?(matchdata[1]) && !privileged_deps.include?(matchdata[1]) } }

  # If a dependency is both a build and a runtime dependency, we remove the build dependency.
  pkgdepsblock.delete_if { |line| line.match(/  depends_on '(.*)' => :build/) { |matchdata| missingpkgdeps.include?(matchdata[1]) } }

  # Remove any duplicate dependencies from the block.
  pkgdepsblock.uniq!

  # Sort the block, trimming the comment from commented out dependencies to enable them to be sorted with the others.
  pkgdepsblock = pkgdepsblock.sort_by { it.delete_prefix('# ') }

  puts "\n Adding to or replacing deps block in package..."

  # Find where we want to insert the dependencies, which is preferrably at the first dependency entry.
  dependency_insert = pkg_file_lines.index { it.include?("depends_on '") }
  # If such an entry does not exist, we take our cues from the positioning of the binary_sha256 hash.
  if dependency_insert.nil?
    dependency_insert = pkg_file_lines.index { it.include?('binary_sha256({') }
    # We then find the end of the binary_sha256 hash, and go from there.
    dependency_insert = pkg_file_lines.index { it.include?('})') && pkg_file_lines.index(it) >= dependency_insert.to_i }

    # We then need to move one past the end of the binary_sha256 hash, and add an empty line at the start of our new dependency block.
    dependency_insert += 1
    pkgdepsblock.prepend('')
  end

  # First remove all dependencies.
  pkg_file_lines.reject! { it.include?("depends_on '") }

  # Now add back our sorted dependencies.
  pkg_file_lines.insert(dependency_insert, pkgdepsblock)
  File.write(pkg_file, pkg_file_lines.join("\n").gsub("\n\n", "\n"))

  # Find the location of the rubocop configuration.
  rubocop_config = CREW_LOCAL_REPO_ROOT.to_s.empty? ? "#{CREW_LIB_PATH}/.rubocop.yml" : File.join(CREW_LOCAL_REPO_ROOT, '.rubocop.yml')

  # Clean with rubocop.
  system "rubocop -c #{rubocop_config} -A #{pkg_file}"
  FileUtils.cp pkg_file, "#{CREW_LOCAL_REPO_ROOT}/packages/#{File.basename(pkg_file)}" unless CREW_LOCAL_REPO_ROOT.to_s.empty?
end

def main(pkg)
  # pkg is pkg.name in this function.
  puts "Checking for the runtime dependencies of #{pkg}...".lightblue
  pkg_file = File.join(CREW_PACKAGES_PATH, "#{pkg}.rb")
  FileUtils.cp File.join(CREW_LOCAL_REPO_ROOT, "packages/#{pkg}.rb"), pkg_file if !CREW_LOCAL_REPO_ROOT.to_s.empty? && File.file?(File.join(CREW_LOCAL_REPO_ROOT, "packages/#{pkg}.rb"))

  if @opt_use_crew_dest_dir
    define_singleton_method('pkgfilelist') { File.join(CREW_DEST_DIR, 'filelist') }
    abort('Pkg was not built.') unless File.exist?(pkgfilelist)
  else
    build_deps = `crew deps -b #{pkg} | sort -u`.split
    build_deps.push(pkg)
    puts "Checking for installation of #{pkg} and all of its build deps to make sure we check to see if any build deps are runtime deps.".orange
    # Packages needs to be installed for package filelist to be populated.
    build_deps.each do |install_package|
      @pkg = Package.load_package("packages/#{install_package}")
      next if PackageUtils.installed?(@pkg.name)
      define_singleton_method('pkgfilelist') { "#{CREW_PREFIX}/etc/crew/meta/#{install_package}.filelist" }
      system("yes | crew install #{install_package}") unless File.exist?(pkgfilelist)
      next if @pkg.is_fake?
      abort("Package #{install_package} either does not exist or does not contain any libraries.") unless File.exist?(pkgfilelist)
    end
  end
  # Reset @pkg.
  @pkg = Package.load_package("packages/#{pkg}")
  define_singleton_method('pkgfilelist') { "#{CREW_PREFIX}/etc/crew/meta/#{pkg}.filelist" }

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
  pkgdeps = pkgdeps.map { |i| i.gsub(/llvm(\d)+_build/, 'llvm_lib') }.uniq
  pkgdeps = pkgdeps.map { |i| i.gsub(/llvm(\d)+_lib/, 'llvm_lib') }.uniq
  pkgdeps = pkgdeps.map { |i| i.gsub(/llvm(\d)+_dev/, 'llvm_dev') }.uniq

  # Leave early if we didn't find any dependencies.
  return if pkgdeps.empty?

  # Write the changed dependencies to the package file.
  write_deps(pkg_file, pkgdeps, @pkg)
end

ARGV.each do |package|
  @pkg = Package.load_package("packages/#{package}")
  main(package.chomp('rb'))
end
