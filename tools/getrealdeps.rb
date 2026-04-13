#!/usr/local/bin/ruby
# getrealdeps version 2.10 (for Chromebrew)
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
#
# Dependencies in Chromebrew can be:
# :build (required only for building.)
# :executable (required only for the executables in the package to run.)
# :library (required for libraries in the package, and thus also for downstream packages.)
# :logical (required for the package to be useful, but not needed in build dependency calculations.)
# The priority in which dependencies are classified is library, executable, logical, build.
# For example, if python3 is both a build and executable dependency, it will be stored as an executable dependency.

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
def whatprovidesfxn(pkgdepslcl, pkg)
  return `crew whatprovides --no-color "#{CREW_LIB_PREFIX}/#{pkgdepslcl}"`.lines[0...-2].flat_map { it.split(':')[0] }.uniq.delete_if { it == pkg }.sort.join(' ')
end

# Write the missing dependencies to the package file.
def write_deps(pkg_file, pkgdeps, pkg, label)
  return if pkgdeps.empty?
  puts "Processing #{label} dependencies for #{pkg.name}...".orange
  suffix = " => :#{label}"

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

  puts "\n#{pkg.name.capitalize} has #{'executables with ' if label == 'executable'}#{'libraries with ' if label == 'library'}these #{'build ' if label == 'build'}#{'logical ' if label == 'logical'}dependencies:".lightblue
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
    puts "\n#{line.chomp} is either not necessary on #{ARCH} as a library dependency or is only a dependency for building or executables.".orange if label == 'library' && line.match(/  depends_on '(.*)'#{suffix}/) { |matchdata| pkgdeps.none?(matchdata[1]) && !privileged_deps.include?(matchdata[1]) }
  end

  # Build dependencies have the lowest priority, so no matter what label we have we want to remove duplicate build dependencies.
  pkgdepsblock.delete_if { it.match(/^  depends_on '(.*)' => :build/) { missingpkgdeps.include?(it[1]) } }

  # Remove runtime dependencies for libraries that already exist but
  # aren't marked as runtime dependencies.
  pkgdepsblock.delete_if { it.match(/(?<=^  depends_on ').*(?='$)/) { pkgdeps.include?(it[0]) } } if label == 'library'

  # If a dependency is listed as both a executable and either a
  # library or generic runtime dependency, we remove the
  # non-executable dependency lines.
  executable_deps_in_package = []
  pkgdepsblock.each { it.match(/(^  depends_on '(.*)' => ).*(:executable.*)/) { executable_deps_in_package.push(it[2]) } }
  pkgdepsblock.delete_if { it.match(/(^  depends_on '(.*)' # R)|(^  depends_on '(.*)' => ).*(:library.*)/) { executable_deps_in_package.include?(it[2]) } }

  # If a dependency is listed as both a old style # R generic runtime
  # dependency and as a library or logical dependency, remove the # R
  # dependency line.
  runtime_deps_in_package_as_library_or_logical = []
  pkgdepsblock.each { it.match(/(^  depends_on '(.*)' => ).*(:library.*)|(^  depends_on '(.*)' => ).*(:logical.*)/) { it[2].nil? ? runtime_deps_in_package_as_library_or_logical.push(it[5]) : runtime_deps_in_package_as_library_or_logical.push(it[2]) } }
  pkgdepsblock.delete_if { it.match(/(^  depends_on '(.*)' # R)/) { runtime_deps_in_package_as_library_or_logical.include?(it[2]) } }

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
  rubocop_config = if File.file?("#{CREW_LOCAL_REPO_ROOT}/packages/#{File.basename(pkg_file)}")
                     FileUtils.identical?(pkg_file, "#{CREW_LOCAL_REPO_ROOT}/packages/#{File.basename(pkg_file)}") ? "#{CREW_LIB_PATH}/.rubocop.yml" : File.join(CREW_LOCAL_REPO_ROOT, '.rubocop.yml')
                   else
                     File.join(CREW_LOCAL_REPO_ROOT, '.rubocop.yml')
                   end

  # Clean with rubocop.
  system "rubocop -c #{rubocop_config} --except Naming/FileName -A #{pkg_file}"
  FileUtils.cp pkg_file, "#{CREW_LOCAL_REPO_ROOT}/packages/#{File.basename(pkg_file)}" if File.file?("#{CREW_LOCAL_REPO_ROOT}/packages/#{File.basename(pkg_file)}") && !FileUtils.identical?(pkg_file, "#{CREW_LOCAL_REPO_ROOT}/packages/#{File.basename(pkg_file)}")
end

def determine_dependencies(pkg_name, pkgfiles_to_check)
  return [] if pkgfiles_to_check.empty?
  # Use readelf to determine library dependencies, as
  # this doesn't almost run a program like using ldd would.
  pkgdepsfiles = pkgfiles_to_check.map do |i|
    system("upx -d #{i} > /dev/null 2>&1")
    FileUtils.mkdir_p("/tmp/deps/#{pkg_name}/")
    `readelf -d "#{i}" 2>/dev/null | #{@grep} NEEDED | awk '{print $5}' | sed 's/\\[//g' | sed 's/\\]//g' | awk '!x[$0]++' | tee /tmp/deps/#{pkg_name}/#{File.basename(i)}`
  end
  pkgdepsfiles = pkgdepsfiles.map do |filedeps|
    filedeps&.split("\n")
  end.flatten.compact.uniq

  # Figure out which Chromebrew packages provide the relevant deps.
  pkgdeps = pkgdepsfiles.map { |file| whatprovidesfxn(file, pkg_name) }

  # Massage the glibc entries in the dependency list.
  pkgdeps = pkgdeps.map { |i| i.gsub(/glibc_build.*/, 'glibc') }.uniq
  pkgdeps = pkgdeps.map { |i| i.gsub(/glibc_lib.*/, 'glibc_lib') }.uniq.map(&:strip).reject(&:empty?)

  # Massage the gcc entries in the dependency list.
  pkgdeps = pkgdeps.map { |i| i.gsub('gcc_build', 'gcc_lib') }.uniq

  # Massage the llvm entries in the dependency list.
  pkgdeps = pkgdeps.map { |i| i.gsub(/llvm(\d)+_build/, 'llvm_lib') }.uniq
  pkgdeps = pkgdeps.map { |i| i.gsub(/llvm(\d)+_lib/, 'llvm_lib') }.uniq
  pkgdeps = pkgdeps.map { |i| i.gsub(/llvm(\d)+_dev/, 'llvm_dev') }.uniq

  # If two packages both provide a library, use the regular one unless this is the specific package that needs the alternative.
  # TODO: Are there more packages like this?
  pkgdeps = pkgdeps.map { |i| i.gsub('glib_stub', 'glib') }.uniq unless %w[gobject_introspection glib].include?(pkg_name)
  # TODO: Since these packages aren't needed by any specific package, do we need to package them at all?
  pkgdeps = pkgdeps.map { |i| i.gsub('jack1', 'jack') }.uniq
  pkgdeps = pkgdeps.map { |i| i.gsub('libxml2_autotools', 'libxml2') }.uniq

  # Split any multi-dependency strings into individual array members.
  pkgdeps = pkgdeps.flat_map(&:split).uniq

  if pkgdeps.blank?
    return []
  else
    return pkgdeps
  end
end

def main(pkg)
  if pkg.is_fake?
    puts "Cannot determine runtime dependencies of fake package #{pkg.name}!".lightred
    return
  end

  puts "Determining #{pkg.name}'s runtime dependencies...".lightblue
  pkg_file = Dir["{#{CREW_LOCAL_REPO_ROOT}/packages,#{CREW_PACKAGES_PATH}}/#{pkg.name}.rb"].max { |a, b| File.mtime(a) <=> File.mtime(b) }
  if @opt_use_crew_dest_dir
    define_singleton_method('pkgfilelist') { File.join(CREW_DEST_DIR, 'filelist') }
    abort('Pkg was not built.') unless File.exist?(pkgfilelist)
  else
    unless PackageUtils.installed?(pkg.name)
      puts "Installing #{pkg.name}.".orange
      system("yes | crew install --ignore-dependencies #{pkg.name}")
    end
    define_singleton_method('pkgfilelist') { "#{CREW_PREFIX}/etc/crew/meta/#{pkg.name}.filelist" }
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

  # Remove the temporary directory created in determine_dependencies.
  FileUtils.rm_rf("/tmp/deps/#{pkg.name}")
  # Remove files we don't care about, such as man files and non-binaries.
  pkgfiles = pkgfiles.reject { |i| !File.file?(i.chomp) || File.read(i.chomp, 4) != "\x7FELF" || i.include?('.zst') }

  # Try to select all libraries based upon filename and location.
  library_pkgfiles = pkgfiles.select { |p| p.include?('.so') || p.include?(CREW_LIB_PREFIX) }
  # Assume executable_pkgfiles is everything left.
  executable_pkgfiles = pkgfiles.reject { |p| library_pkgfiles.include?(p) }

  # Determine dependencies for each subset of files.
  library_deps = determine_dependencies(pkg.name, library_pkgfiles).compact
  executable_deps = determine_dependencies(pkg.name, executable_pkgfiles).compact

  # Add logical deps for perl, pip, python, and ruby gem packages.
  buildsystem_dependencies = { PERL: 'perl', Pip: 'python3', Python: 'python3', RUBY: 'ruby' }
  logical_deps = [buildsystem_dependencies[pkg.superclass.to_s.to_sym]].compact

  # Remove duplicate dependencies in the priority order of library, executable, logical, build.
  # We currently handle duplicate build dependencies in write_deps.
  logical_deps = logical_deps.difference(executable_deps, library_deps)
  executable_deps = executable_deps.difference(library_deps)

  # Write the changed dependencies to the package file.
  # Note that most logical and all build dependencies are added manually.
  write_deps(pkg_file, logical_deps, pkg, 'logical') unless logical_deps.empty?
  write_deps(pkg_file, executable_deps, pkg, 'executable') unless executable_deps.empty?
  write_deps(pkg_file, library_deps, pkg, 'library') unless library_deps.empty?
  FileUtils.cp pkg_file, File.join(CREW_LOCAL_REPO_ROOT, "packages/#{pkg.name}.rb") unless FileUtils.identical?(pkg_file, File.join(CREW_LOCAL_REPO_ROOT, "packages/#{pkg.name}.rb"))
  FileUtils.cp pkg_file, File.join(CREW_PACKAGES_PATH, "#{pkg.name}.rb") unless FileUtils.identical?(pkg_file, File.join(CREW_PACKAGES_PATH, "#{pkg.name}.rb"))
end

ARGV.each do |package|
  main(Package.load_package("packages/#{package}"))
end
