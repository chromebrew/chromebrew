#!/usr/local/bin/ruby
# build_updated_packages version 5.2 (for Chromebrew)
# This updates the versions in python pip packages by calling
# tools/update_python_pip_packages.rb, checks for updated ruby packages
# by calling tools/update_ruby_gem_packages.rb, and then checks if any
# packages have been updated that need updated binaries. If so, it tries
# to build those binaries.
#
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in root of cloned chromebrew repo with a new branch checked out:
# tools/build_updated_packages.rb [--skip]
# Pass '--skip' as an argument to avoid running the pip and gen update scripts.
# This is useful if you have already run this (and thus the update scripts)
# from another container for the same cloned repo.

require 'English'
require 'fileutils'
require 'net/http'

crew_local_repo_root = `git rev-parse --show-toplevel 2> /dev/null`.chomp
# When invoked from crew, pwd is CREW_DEST_DIR, so crew_local_repo_root
# is empty.
crew_local_repo_root = '../' if crew_local_repo_root.to_s.empty?
require File.join(crew_local_repo_root, 'lib/color')
require File.join(crew_local_repo_root, 'lib/const')
require File.join(crew_local_repo_root, 'lib/package')
require File.join(crew_local_repo_root, 'lib/package_utils')
require File.join(crew_local_repo_root, 'lib/require_gem')
require_gem 'dagwood'
require_gem 'highline'
require_gem 'timeout'

# Add >LOCAL< lib to LOAD_PATH
$LOAD_PATH.unshift File.join(crew_local_repo_root, 'lib')

OPTIONS = %w[-h --help --check-all-python --check-all-ruby --continue-after-failed-builds --ignore-changed-packages --rebuild --skip -v --verbose -vv]

if ARGV.include?('-h') || ARGV.include?('--help')
  abort <<~EOM
    Usage: ./build_updated_packages.rb [<package>] #{OPTIONS.to_s.gsub('"', '')}
    Example: ./build_updated_packages.rb abcde -v
    If <package> is omitted, recently updated files will be checked for needed builds.
    Passing --continue-after-failed-builds will continue if builds fail.
    Passing --ignore-changed-packages will not check packages git reports as having changed.
    Passing --rebuild will rebuild packages even if binaries already exist upstream.
    Passing --skip will skip update checks.
    Passing --check-all-python will check py3_ pip packages for updates.
    Passing --check-all-ruby will check ruby_ gem packages for updates.
    Passing --verbose or -v will display verbose output.
    Passing -vv will display very verbose output.
  EOM
end

# We don't directly use the GITLAB_TOKEN* environment variables, but crew upload does, so we check for them here so that we don't build a package and then fail to upload it.
abort "\nGITLAB_TOKEN environment variable not set.\n".lightred if ENV['GITLAB_TOKEN'].nil?
abort "\nGITLAB_TOKEN_USERNAME environment variable not set.\n".lightred if ENV['GITLAB_TOKEN_USERNAME'].nil?
puts "Setting the CREW_AGREE_TIMEOUT_SECONDS environment variable to less than the default of #{CREW_AGREE_TIMEOUT_SECONDS} may speed this up...".orange if ENV['CREW_AGREE_TIMEOUT_SECONDS'].nil?

CONTINUE_AFTER_FAILED_BUILDS = ARGV.include?('--continue-after-failed-builds')
REBUILD_PACKAGES = ARGV.include?('--rebuild')
IGNORE_CHANGED_PACKAGES = ARGV.include?('--ignore-changed-packages')
SKIP_UPDATE_CHECKS = ARGV.include?('--skip')
CHECK_ALL_PYTHON = ARGV.include?('--check-all-python')
CHECK_ALL_RUBY = ARGV.include?('--check-all-ruby')
VERBOSE = ARGV.include?('-v') || ARGV.include?('--verbose') || ARGV.include?('-vv')
VERY_VERBOSE = ARGV.include?('-vv')

updated_packages = []
# Handle multiple packages being passed.
argv = ARGV.map(&:split).flatten
if argv.length.positive? && !(argv.length == 1 && OPTIONS.include?(argv[0]))
  argv.each do |arg|
    arg = arg.gsub('.rb', '')
    next unless arg =~ /^[0-9a-zA-Z_*]+$/

    filename = File.join(crew_local_repo_root, "packages/#{arg}.rb")
    updated_packages.push "packages/#{arg}.rb" if File.exist?(filename)
    puts "#{arg} has been added to the list of packages to be checked for updates.".lightblue
  end
end

# Check env for CREW_ARCH_PACKAGES_ENCODED variable that may have been
# passed in with encoded package names, as that avoids space in variable
# name issues when invoking subshells in container start.
ARCH_PACKAGES_ENCODED = ENV.fetch('CREW_ARCH_PACKAGES_ENCODED', nil)
ARCH_PACKAGES = ARCH_PACKAGES_ENCODED.nil? || !system('xxd -v &>/dev/null') ? nil : `echo #{ARCH_PACKAGES_ENCODED} | xxd -ps -r`.chomp
ARCH_PACKAGES&.split { updated_packages.push "packages/#{it}.rb" if File.exist?(File.join(crew_local_repo_root, "packages/#{it}.rb")) }

build = {}

excluded_packages = Set[
  { pkg_name: 'glibc_fallthrough', comments: 'Stub package.' },
  { pkg_name: 'py3_unsupported_python', comments: 'Stub package.' }
]
excluded_pkgs = excluded_packages.map { it[:pkg_name] }

dependent_packages_to_check = Set[
  { pkg_name: 'gcc_build', downstream_packages: 'gcc_lib', comments: '' },
  { pkg_name: 'gcc_lib', downstream_packages: 'gcc_dev', comments: '' },
  { pkg_name: 'gcc_dev', downstream_packages: 'libssp', comments: '' },
  { pkg_name: "#{CREW_LLVM_VER}_build", downstream_packages: "#{CREW_LLVM_VER}_lib", comments: '' },
  { pkg_name: "#{CREW_LLVM_VER}_lib", downstream_packages: "#{CREW_LLVM_VER}_dev", comments: '' },
  { pkg_name: "#{CREW_LLVM_VER}_dev", downstream_packages: 'openmp spirv_llvm_translator libclc', comments: '' },
  { pkg_name: 'spirv_llvm_translator', downstream_packages: 'libclc', comments: '' }
]
dependent_pkgs = dependent_packages_to_check.to_h { [it[:pkg_name], it[:downstream_packages]] }

def self.agree_default_yes(message = nil)
  Timeout.timeout(CREW_AGREE_TIMEOUT_SECONDS) do
    return agree_with_default("#{message} (YES/no)?", true, default: 'y')
  end
rescue Timeout::Error
  return true
end

def self.check_build_uploads(pkg)
  return [] if pkg.is_fake?

  architectures_to_check = pkg.compatibility == 'all' ? %w[armv7l i686 x86_64] : pkg.compatibility.split
  architectures_to_check.delete('aarch64')

  # If we are rebuilding packages, we don't care if they already have builds uploaded to gitlab.
  return architectures_to_check if REBUILD_PACKAGES

  # Delete every architecture that has a corresponding build already uploaded to gitlab.
  architectures_to_check.delete_if do |arch|
    arch_specific_url = "#{CREW_GITLAB_PKG_REPO}/generic/#{pkg.name}/#{pkg.version}_#{arch}/#{pkg.name}-#{pkg.version}-chromeos-#{arch}.#{pkg.binary_compression}"

    Net::HTTP.get_response(URI.parse(arch_specific_url)).code == '200'
  end

  # Return the architectures that do not have a corresponding build uploaded.
  return architectures_to_check
end

def update_hashes_and_manifests(pkg)
  unless CREW_BUILD_NO_PACKAGE_FILE_HASH_UPDATES
    # Update/add build hashes if this package has builds.
    system "crew update_package_file #{pkg.name}" unless pkg.no_compile_needed?
    # Add manifests if we are in the right architecture.
    if PackageUtils.compatible?(pkg)
      # Using crew reinstall -f package here updates the hashes for
      # binaries.
      if system("yes | crew reinstall --regenerate-filelist #{'-f' unless CREW_BUILD_NO_PACKAGE_FILE_HASH_UPDATES} #{pkg.name}") && File.exist?("#{CREW_META_PATH}/#{pkg.name}.filelist") && File.directory?(CREW_LOCAL_REPO_ROOT)
        puts 'Adding manifests...'
        FileUtils.cp "#{CREW_META_PATH}/#{pkg.name}.filelist", "#{CREW_LOCAL_REPO_ROOT}/manifest/#{ARCH}/#{pkg.name.chr}/#{pkg.name}.filelist"
      end
    else
      puts PackageUtils.incompatible_reason(pkg).join("\n").orange
      puts 'Manifests will not be added.'.lightred
      return
    end
  end
end

def update_deps(pkg)
  unless CREW_BUILD_NO_PACKAGE_FILE_HASH_UPDATES
    # Update package dependencies.
    if PackageUtils.compatible?(pkg)
      Kernel.system "tools/getrealdeps.rb #{pkg.name}"
    else
      puts PackageUtils.incompatible_reason(pkg).join("\n").orange
      puts 'Dependencies will not be checked.'.lightred
    end
  end
end

def determine_recursive_deps(d_pkg_input, dependency_graphs: {})
  # How to hardcode a dependency:
  # @gcc_lib_graph = Dagwood::DependencyGraph.new(gcc_lib: %i[glibc])
  # @glibc_graph = Dagwood::DependencyGraph.new(glibc: nil)
  # @glibc_build227_graph = Dagwood::DependencyGraph.new(glibc_build227: %i[glibc])
  # @glibc_build227_graph.merge(@glibc_graph)
  # @gcc_lib_graph.merge(@glibc_graph)
  [d_pkg_input].flatten.each do |d_pkg|
    d_pkg_obj = Package.load_package("packages/#{d_pkg}.rb")
    d_pkg_deps = d_pkg_obj.dependencies.map { |key, value| key.to_s if value == [[], nil] }.compact
    # Pull in build dependencies if necessary.
    if (d_pkg.include?('_lib') || d_pkg.include?('_dev')) && !d_pkg.include?('gcc_lib')
      puts "#{"#{__LINE__}: " if CREW_VERBOSE}#{d_pkg} includes _dev || _lib, pulling build deps.".orange
      # d_pkg_deps = d_pkg_obj.get_deps_list(exclude_buildessential: false).delete_if { |d| ( d == 'glibc' || d == 'gcc_lib' ) }
      d_pkg_deps = d_pkg_obj.dependencies.map { |key, _value| key.to_s }.compact.delete_if { |d| %w[glibc gcc_lib].include?(d) }
    end
    dependency_graphs[d_pkg] = Dagwood::DependencyGraph.new({ d_pkg.to_sym => (d_pkg_deps.map &:to_sym) }) if dependency_graphs[d_pkg].nil?

    next unless !dependency_graphs[d_pkg].nil? && !dependency_graphs[d_pkg].dependencies.nil?

    next if d_pkg_deps.empty?
    d_pkg_deps.each do |d|
      dependency_graphs = determine_recursive_deps(d, dependency_graphs:) if dependency_graphs[d].nil?
      begin
        # puts "#{"#{__LINE__}: " if CREW_VERBOSE}order for #{d} is #{instance_variable_get("@#{d}_graph").order}".lightpurple
        # puts "#{"#{__LINE__}: " if CREW_VERBOSE}order for #{d} is #{dependency_graphs[d_pkg].order}".lightpurple
        # Make sure that the dependency tree for each d_pkg dependency
        # d is copacetic. If not error out with a complaint.
        dependency_graphs[d_pkg].order
      rescue TSort::Cyclic => e
        puts "#{"#{__LINE__}: " if CREW_VERBOSE}Error processing dependencies for #{d_pkg}:".lightred
        puts "#{"#{__LINE__}: " if CREW_VERBOSE}Circular dependency detected from #{dependency_graphs[d].dependencies}:".lightred
        abort "#{"#{__LINE__}: " if CREW_VERBOSE}#{e.message}".lightred
      end
      dependency_graphs[d_pkg] = dependency_graphs[d_pkg].merge(dependency_graphs[d]) unless dependency_graphs[d].dependencies.nil?
    end
  end

  return dependency_graphs
end

def print_recursive_deps(d_pkg_input, dependency_graphs)
  [d_pkg_input].flatten.each do |p|
    abort "@#{p}_graph does not exist!".lightred unless !dependency_graphs[p].nil? && !dependency_graphs[p].dependencies.nil?
    deps = dependency_graphs[p].dependencies
    puts deps.to_s.lightblue

    begin
      puts dependency_graphs[p].order
    rescue RuntimeError => e
      puts e.message.lightred
    rescue TSort::Cyclic => e
      puts "Circular dependency detected: #{e.message}".lightred
    end
  end
end

def order_recursive_deps(d_pkg_input)
  d_pkgs = [d_pkg_input].flatten
  puts "#{"#{__LINE__}: " if CREW_VERBOSE}Processing dependencies...".lightpurple
  dependency_graphs = determine_recursive_deps(d_pkgs)
  input_pkgs = d_pkgs.to_set
  merge_base = dependency_graphs[d_pkgs.pop]

  d_pkgs.each do |p|
    begin
      merge_base.order
    rescue TSort::Cyclic => e
      puts "#{"#{__LINE__}: " if CREW_VERBOSE}Circular dependency detected from #{merge_base.dependencies}:".lightpurple
      abort e.message.to_s.lightred
    end
    merge_base = merge_base.merge(dependency_graphs[p])
    # puts "#{"#{__LINE__}: " if CREW_VERBOSE}merge_base.order is now #{merge_base.order}".lightpurple
  end
  package_deps_build_order = merge_base.order.to_set(&:to_s)
  # Want the intersection of these sets, but the intersection appears
  # to reorder the result, which isn't what we want.
  return package_deps_build_order.delete_if { |p| !input_pkgs.include? p }.to_a
end

# Do not execute anything if we are required as a library rather than being run as a script.
return unless __FILE__ == $PROGRAM_NAME

if SKIP_UPDATE_CHECKS
  puts 'Skipping pip and gem remote update checks.'.orange
else
  puts 'Checking for pip package version updates...'.orange
  Kernel.system 'tools/update_python_pip_packages.rb'
  puts 'Checking for ruby gem package version updates...'.orange
  Kernel.system 'tools/update_ruby_gem_packages.rb'
end

if IGNORE_CHANGED_PACKAGES
  puts 'Skipping checks for packages git marks as having changed.'.orange
else
  puts 'Checking packages git marks as having changed.'.orange
  changed_files = `git diff HEAD --name-only`.chomp.split
  changed_files_previous_commit = `git diff-tree --no-commit-id --name-only -r $(git rev-parse origin/master)..$(git rev-parse --verify HEAD)`.chomp.split
  updated_packages.push(*changed_files.grep(%r{(packages/).*.*(\.rb$)}))
  updated_packages.push(*changed_files_previous_commit.grep(%r{(packages/).*.*(\.rb$)}))
end

crew_update_packages = `CREW_NO_GIT=1 CREW_UNATTENDED=1 crew update | grep "\\[\\""  | jq -r '.[]'`.chomp.split.map(&'packages/'.method(:+)).map { |i| i.concat('.rb') }
if CHECK_ALL_PYTHON
  py_packages = `grep -l CREW_PY_VER packages/*`.chomp.split
  updated_packages.push(*py_packages)
end
if CHECK_ALL_RUBY
  ruby_packages = `grep -l CREW_RUBY_VER packages/*`.chomp.split
  updated_packages.push(*ruby_packages)
end
updated_packages.push(*crew_update_packages)
updated_packages.uniq!

# Remove packages that don't need to be checked for updates from the
# check list.
exclusion_regex = "(#{excluded_pkgs.join('|')})"
updated_packages.delete_if { |d| /#{exclusion_regex}/.match(d) }

# Add additional packages that need to be checked for updates.
inclusion_regex = "(#{dependent_pkgs.keys.join('|')})"
updated_packages.each do |p|
  pkg = p.sub('packages/', '').sub('.rb', '')
  next unless /#{inclusion_regex}/.match(pkg)
  dependent_pkgs[pkg].split.each do |dependent_pkg|
    if File.exist?(File.join(crew_local_repo_root, "packages/#{dependent_pkg}.rb"))
      puts "Will check #{dependent_pkg} since dependent package of #{pkg}...".orange if VERY_VERBOSE
      updated_packages.push "packages/#{dependent_pkg}.rb"
    end
  end
end

if updated_packages.empty?
  puts 'No packages need to be updated.'.orange
else
  updated_packages.uniq!
  updated_packages_reordered = order_recursive_deps(updated_packages.map { |p| p.sub('packages/', '').sub('.rb', '') }).map { |p| "packages/#{p}.rb" }
  puts 'These packages will be checked to see if they need updated binaries:'.orange
  unless updated_packages == updated_packages_reordered
    puts "#{"#{__LINE__}: " if CREW_VERBOSE}Packages to check have been reordered!".lightpurple
    updated_packages = updated_packages_reordered
  end
  updated_packages.each { |p| puts " #{p.sub('packages/', '').sub('.rb', '').to_s.lightblue}" }
end

updated_packages.each do |pkg|
  name = pkg.sub('packages/', '').sub('.rb', '')
  next unless File.file?(pkg)

  puts "Evaluating #{name} package...".lightpurple
  system "rubocop -c .rubocop.yml -A #{pkg}"
  pkg_obj = Package.load_package(pkg)

  # Handle case of no_compile_needed ruby gems actually containing
  # libraries requiring compiles, in which which case we need to disable
  # no_compile_needed and add gem_compile_needed, which the ruby
  # buildsystem will add.
  if pkg_obj.superclass.to_s == 'RUBY' && pkg_obj.no_compile_needed?
    puts "#{name} is a gem package.".lightblue
    system "yes | crew reinstall #{'-f' unless CREW_BUILD_NO_PACKAGE_FILE_HASH_UPDATES} #{name}"
    if File.file?("#{CREW_META_PATH}/#{name}.filelist") && system("grep '.so$' #{CREW_META_PATH}/#{name}.filelist", exception: false)
      puts "#{name} gem has libraries.".lightblue
      require_relative '../lib/buildsystems/ruby'
      add_gem_binary_compression(name)
      puts "Copying #{File.join(CREW_PACKAGES_PATH, pkg.sub('packages/', ''))} to #{pkg}".lightblue
      FileUtils.cp File.join(CREW_PACKAGES_PATH, pkg.sub('packages/', '')), pkg
      puts "Reinvoking #{$PROGRAM_NAME} #{ARGV.join(' ')}".orange
      exec "#{$PROGRAM_NAME} #{ARGV.join(' ')}", chdir: `pwd`.chomp
    else
      puts "#{name} gem may have no libraries.".lightblue
    end
  end

  # Don't check if we need new binaries if the package doesn't already
  # have binaries for this architecture.
  if !system("grep -q binary_sha256 #{pkg}") && !pkg_obj.no_compile_needed? && !pkg_obj.gem_compile_needed?
    puts "#{name.capitalize} #{pkg_obj.version} has no binaries and may not need them.".lightgreen
    next pkg
  elsif pkg_obj.no_compile_needed?
    update_hashes_and_manifests(pkg_obj)
  else
    puts "#{name.capitalize} appears to need binaries. Checking to see if current binaries exist...".orange
    builds_needed = check_build_uploads(pkg_obj)
    if builds_needed.empty?
      puts "No builds are needed for #{name} #{pkg_obj.version}.".lightgreen
      update_hashes_and_manifests(pkg_obj)
      update_deps(pkg_obj)
      puts "Copying #{File.join(CREW_PACKAGES_PATH, pkg.sub('packages/', ''))} to #{pkg}".lightblue
      FileUtils.cp File.join(CREW_PACKAGES_PATH, pkg.sub('packages/', '')), pkg
      next
    else
      puts "#{name.capitalize} #{pkg_obj.version} needs builds uploaded for: #{builds_needed.join(' ')}".lightblue

      if builds_needed.include?(ARCH) && !File.file?("release/#{ARCH}/#{name}-#{pkg_obj.version}-chromeos-#{ARCH}.#{pkg_obj.binary_compression}") && agree_default_yes("\nWould you like to build #{name} #{pkg_obj.version}")
        # GitHub actions are killed after 6 hours, so  eed to force
        # creation of build artifacts for long-running builds.
        if ENV['NESTED_CI']
          # Sleep for CREW_MAX_BUILD_TIME seconds, then send SIGINT to
          # @pkg.build, which should trigger a build artifact upload.
          puts "It is #{Time.now}."
          puts "Will kill the build of #{name.capitalize} after #{Float(format('%.2g', CREW_MAX_BUILD_TIME.to_f / 3600))} hours at #{Time.at(Time.now.to_i + CREW_MAX_BUILD_TIME.to_i)}."
          actions_timed_killer = fork do
            exec "sleep #{CREW_MAX_BUILD_TIME}; killall -s INT crew; sleep 300; killall ruby"
          end
          Process.detach(actions_timed_killer)
        end
        system "yes | #{'CREW_CACHE_BUILD=1' if ENV['NESTED_CI']} nice -n 20 crew build #{'-v' if VERBOSE} -f #{pkg}"
        build[name.to_sym] = $CHILD_STATUS.success?
        unless build[name.to_sym]
          if CONTINUE_AFTER_FAILED_BUILDS
            puts "#{pkg} build failed!".lightred
            next
          else
            abort "#{pkg} build failed!".lightred
          end
        end
        Process.kill('HUP', actions_timed_killer) if ENV['NESTED_CI']
        # Reinvoke this script to take just built packages that have been built and
        # installed into account, attempting uploads of just built packages immediately.
        cmdline = "cd #{`pwd`.chomp} && crew upload #{name} #{'--force' if REBUILD_PACKAGES} ; #{$PROGRAM_NAME} #{ARGV.join(' ')}"
        puts "cmdline is #{cmdline}"
        exec cmdline
      end
      upload_pkg = nil
      builds_needed.each do |build|
        upload_pkg = true if File.file?("release/#{build}/#{name}-#{pkg_obj.version}-chromeos-#{build}.#{pkg_obj.binary_compression}")
      end
      system('yes | crew reinstall py3_twine', %i[out err] => File::NULL) unless system('twine --help', %i[out err] => File::NULL)
      if system("crew check #{name}")
        system "crew upload -v #{name}" if upload_pkg == true && agree_default_yes("\nWould you like to upload #{name} #{pkg_obj.version}")
        system "rubocop -c .rubocop.yml -A #{pkg}"
      else
        abort "Failed: crew check #{name}".lightred
      end
      puts "Are builds still needed for #{name}?".orange
      builds_still_needed = check_build_uploads(pkg_obj)
      puts "Built and Uploaded: #{name} for #{ARCH}" if builds_needed != builds_still_needed
      # next if builds_still_needed.empty? && system("grep -q binary_sha256 #{pkg}")
      next if builds_still_needed.empty?

      puts "#{name.capitalize} #{pkg_obj.version} still needs builds uploaded for: #{builds_still_needed.join(' ')}".lightblue unless builds_still_needed.empty? && system("grep -q binary_sha256 #{pkg}")
      puts "#{name.capitalize} #{pkg_obj.version} still needs build sha256 hashes added.".lightblue unless system("grep -q binary_sha256 #{pkg}")
    end
  end
end
