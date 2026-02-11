#!/usr/local/bin/ruby
# getrealdeps version 2.7 (for Chromebrew)
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
def write_deps(pkg_file, pkgdeps, pkg, label)
  return if pkgdeps.empty?
  case label
  when 'bin'
    puts "Processing executable dependencies for #{pkg.name}...".orange
    suffix = ' => :executable_only'
  when 'build'
    puts "Processing build dependencies for #{pkg.name}...".orange
    suffix = ' => :build'
  when 'lib'
    puts "Processing library dependencies for #{pkg.name}...".orange
    suffix = ' # R'
  when 'logical'
    puts "Processing logical dependencies for #{pkg.name}...".orange
    suffix = ' => :logical'
  end
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
    { name_regex: 'harfbuzz', exclusion_regex: '(fontconfig|freetype)', comments: 'fontconfig overwrites parts of harfbuzz, and harfbuzz provides a freetype stub that is overwritten' },
    { name_regex: 'llvm.*_build', exclusion_regex: 'llvm.*_*', comments: 'created from the llvm build package.' },
    { name_regex: '(llvm.*_dev|llvm.*_lib|libclc|openmp)', exclusion_regex: 'llvm.*_build', comments: 'should only be a build dep.' },
    { name_regex: 'llvm.*_lib', exclusion_regex: 'llvm_lib', comments: 'should only be a build dep.' },
    { name_regex: 'gcc_build', exclusion_regex: 'gcc.*_*', comments: 'created from the gcc_build package.' },
    { name_regex: '(gcc_dev|gcc_lib|libssp)', exclusion_regex: 'gcc_build', comments: 'should only be a build dep.' },
    { name_regex: 'gcc_lib', exclusion_regex: 'gcc_lib', comments: 'should only be a build dep.' },
    { name_regex: 'python3', exclusion_regex: '(tcl|tk)', comments: 'optional for i686, which does not have gui libraries.' },
    { name_regex: 'util_linux', exclusion_regex: 'python3', comments: 'Avoid circular dependency.' }
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

  puts "\n#{pkg.name.capitalize} has #{'executables with ' if label == 'bin'}#{'libraries with ' if label == 'lib'} these dependencies:".lightblue
  pkgdeps.each do |i|
    puts "  depends_on '#{i}'#{suffix}".lightgreen
  end
  pkg_read = File.read(pkg_file)
  # Look for runtime dependencies that aren't already provided by the
  # package, excepting build and logical dependencies, which get
  # installed anyways.
  missingpkgdeps = pkgdeps.reject { pkg_read.include?("depends_on '#{it}'#{suffix}") unless pkg_read.include?("depends_on '#{it}' => :build") }
  missingpkgdeps = missingpkgdeps.reject { pkg_read.include?("depends_on '#{it}'#{suffix}") unless pkg_read.include?("depends_on '#{it}' => :logical") }

  unless missingpkgdeps.empty?
    puts "\nPackage file #{pkg_file} is missing these dependencies:".orange
    puts "  depends_on '#{missingpkgdeps.join("#{suffix}\n  depends_on '")}#{suffix}".orange
  end

  # Read the package file into an array of lines without newlines.
  pkg_file_lines = File.readlines(pkg_file)

  # Remove newlines from the end of each line to allow better
  # duplicate removal.
  pkgdepsblock = pkg_file_lines.filter { it.include?("depends_on '") }.map(&:chomp)

  pkgdepsblock += pkgdeps.map { "  depends_on '#{it}'#{suffix}" }

  # Add any missing runtime dependencies to the block of dependencies.
  pkgdepsblock += missingpkgdeps.map { "  depends_on '#{it}'#{suffix}" }
  pkgdepsblock.uniq!

  # These deps are sometimes architecture dependent or should not be removed for other reasons.
  privileged_deps = %w[glibc glibc_lib gcc_lib perl python3 ruby]

  # Check for and delete old runtime dependencies.
  # Its unsafe to do this with other dependencies, because the packager might know something we don't.
  # pkgdepsblock.delete_if { it.match(/  depends_on '(.*)' # R/) { |matchdata| pkgdeps.none?(matchdata[1]) && !privileged_deps.include?(matchdata[1]) } }

  # We need to figure out how to handle architecture specific dependencies.
  # e.g., smbclient on x86_64 has a lmdb dependency, but not on armv7l.
  pkgdepsblock.each do |line|
    puts "\n#{line.chomp} is either not necessary on #{ARCH} as a library dependency or is only a dependency for building or executables.".orange if label == 'lib' && line.match(/  depends_on '(.*)'#{suffix}/) { |matchdata| pkgdeps.none?(matchdata[1]) && !privileged_deps.include?(matchdata[1]) }
  end

  # If a dependency is both a build and a runtime dependency, we remove the build dependency.
  pkgdepsblock.delete_if { it.match(/^  depends_on '(.*)' => :build/) { missingpkgdeps.include?(it[1]) } }
  # Remove runtime dependencies for libraries that already exist but
  # aren't marked as runtime dependencies.
  pkgdepsblock.delete_if { it.match(/(?<=^  depends_on ').*(?='$)/) { pkgdeps.include?(it[0]) } } if label == 'lib'

  # If a dependency is listed as both a executable_only and a runtime dependency, we remove the runtime dependency.
  pkgdepsblock.delete_if { it.match(/^  depends_on '(.*)' # R/) { missingpkgdeps.include?(it[1]) } } if label == 'bin'

  # Deduplicate for lines with comments.
  pkgdepsblock.delete_if { it.match(/(?<=^  depends_on ').*(?='#{suffix}$)/) { !pkg_file_lines.map(&:chomp).grep(/^  depends_on '.*#{it[0]}.*'#{suffix} \S/).blank? } }

  # Sort the block, trimming the comment from commented out dependencies
  # to enable them to be sorted with the others.
  # Remove newlines from the block to better remove duplicates.
  pkgdepsblock = pkgdepsblock.sort_by { it.sub('  # ', '  ') }.map(&:chomp).uniq

  puts "\nAdding to or replacing dependency block in #{pkg_file}..."

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
  rubocop_config = FileUtils.identical?(pkg_file, "#{CREW_LOCAL_REPO_ROOT}/packages/#{File.basename(pkg_file)}") ? "#{CREW_LIB_PATH}/.rubocop.yml" : File.join(CREW_LOCAL_REPO_ROOT, '.rubocop.yml')

  # Clean with rubocop.
  system "rubocop -c #{rubocop_config} -A #{pkg_file}"
  FileUtils.cp pkg_file, "#{CREW_LOCAL_REPO_ROOT}/packages/#{File.basename(pkg_file)}" unless FileUtils.identical?(pkg_file, "#{CREW_LOCAL_REPO_ROOT}/packages/#{File.basename(pkg_file)}")
end

def determine_dependencies(pkg, pkgfiles_to_check)
  return if pkgfiles_to_check.empty?
  # Use readelf to determine library dependencies, as
  # this doesn't almost run a program like using ldd would.
  pkgdepsfiles = pkgfiles_to_check.map do |i|
    system("upx -d #{i} > /dev/null 2>&1")
    FileUtils.mkdir_p("/tmp/deps/#{pkg}/")
    `readelf -d "#{i}" 2>/dev/null | #{@grep} NEEDED | awk '{print $5}' | sed 's/\\[//g' | sed 's/\\]//g' | awk '!x[$0]++' | tee /tmp/deps/#{pkg}/#{File.basename(i)}`
  end
  pkgdepsfiles = pkgdepsfiles.map do |filedeps|
    filedeps&.split("\n")
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
  # return if pkgdeps.empty?
  return pkgdeps
end

def main(pkg)
  # pkg is @pkg.name in this function.
  puts "Determining #{pkg}'s runtime dependencies...".lightblue
  pkg_file = Dir["{#{CREW_LOCAL_REPO_ROOT}/packages,#{CREW_PACKAGES_PATH}}/#{pkg}.rb"].max { |a, b| File.mtime(a) <=> File.mtime(b) }
  if @opt_use_crew_dest_dir
    define_singleton_method('pkgfilelist') { File.join(CREW_DEST_DIR, 'filelist') }
    abort('Pkg was not built.') unless File.exist?(pkgfilelist)
  else
    # build_deps = `crew deps -b #{pkg} | sort -u`.split
    packages_which_need_to_be_installed = @pkg.get_deps_list(include_build_deps: true)
    # Add pkg to the list of packages we are going to install to make
    # sure filelists are available.
    packages_which_need_to_be_installed.push(@pkg.name)
    puts "Installing or reinstalling #{pkg} and its build dependencies.".orange
    # Packages needs to be installed for package filelist to be populated.
    packages_which_need_to_be_installed.each do |install_package|
      @install_pkg = Package.load_package("packages/#{install_package}")
      next if PackageUtils.installed?(@install_pkg.name)
      define_singleton_method('pkgfilelist') { "#{CREW_PREFIX}/etc/crew/meta/#{install_package}.filelist" }
      system("yes | crew install #{install_package}") unless File.exist?(pkgfilelist)
      next if @install_pkg.is_fake?
      abort "Package #{install_package} either does not exist or does not contain any libraries.".lightred unless File.exist?(pkgfilelist)
    end
    define_singleton_method('pkgfilelist') { "#{CREW_PREFIX}/etc/crew/meta/#{pkg}.filelist" }
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

  # Try to select all libraries based upon filename and location.
  lib_pkgfiles = pkgfiles.select { |p| p.include?('.so') || p.include?(CREW_LIB_PREFIX) }
  # Assume bin_pkgfiles is everything left.
  bin_pkgfiles = pkgfiles.reject { |p| lib_pkgfiles.include?(p) }

  # Determine dependencies for each subset of files.
  lib_deps = determine_dependencies(pkg, lib_pkgfiles)
  bin_deps = determine_dependencies(pkg, bin_pkgfiles)
  bin_deps = lib_deps.nil? ? bin_deps : (bin_deps - lib_deps)

  # Write the changed dependencies to the package file.
  write_deps(pkg_file, bin_deps, @pkg, 'bin') unless bin_deps.nil?
  write_deps(pkg_file, lib_deps, @pkg, 'lib') unless lib_deps.nil?
  FileUtils.cp pkg_file, File.join(CREW_LOCAL_REPO_ROOT, "packages/#{pkg}.rb") unless FileUtils.identical?(pkg_file, File.join(CREW_LOCAL_REPO_ROOT, "packages/#{pkg}.rb"))
  FileUtils.cp pkg_file, File.join(CREW_PACKAGES_PATH, "#{pkg}.rb") unless FileUtils.identical?(pkg_file, File.join(CREW_PACKAGES_PATH, "#{pkg}.rb"))
end

ARGV.each do |package|
  @pkg = Package.load_package("packages/#{package}")
  main(package.chomp('rb'))
end
