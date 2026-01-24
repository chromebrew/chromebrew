#!/usr/local/bin/ruby
# build_updated_packages version 4.3 (for Chromebrew)
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

crew_local_repo_root = `git rev-parse --show-toplevel 2> /dev/null`.chomp
# When invoked from crew, pwd is CREW_DEST_DIR, so crew_local_repo_root
# is empty.
crew_local_repo_root = '../' if crew_local_repo_root.to_s.empty?
require File.join(crew_local_repo_root, 'lib/color')
require File.join(crew_local_repo_root, 'lib/const')
require File.join(crew_local_repo_root, 'lib/package')
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

build = {}

excluded_packages = Set[
  { pkg_name: 'glibc_fallthrough', comments: 'Stub package.' },
  { pkg_name: 'py3_unsupported_python', commwnts: 'Stub package.' },
  { pkg_name: 'terraform', comments: 'Needs manual update due to package structure.' }
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

def self.check_build_uploads(architectures_to_check = nil, name = nil)
  return [] if @pkg_obj.is_fake?
  architectures_to_check.delete('aarch64')
  architectures_to_check = %w[x86_64 armv7l i686] if (architectures_to_check & %w[x86_64 armv7l i686]).nil?

  return architectures_to_check if REBUILD_PACKAGES

  remote_binary = { armv7l: nil, i686: nil, x86_64: nil }
  remote_binary.keys.each do |arch|
    arch_specific_url = "#{CREW_GITLAB_PKG_REPO}/generic/#{name}/#{@pkg_obj.version}_#{arch}/#{name}-#{@pkg_obj.version}-chromeos-#{arch}.#{@pkg_obj.binary_compression}"
    puts "Checking: curl -sI #{arch_specific_url}" if VERBOSE
    remote_binary[arch.to_sym] = `curl -sI #{arch_specific_url}`.lines.first.split[1] == '200'
    puts "#{arch_specific_url} found!" if remote_binary[arch.to_sym] && VERBOSE
  end
  system "crew update_package_file #{name}" unless remote_binary.values.all?(nil)

  builds_needed = architectures_to_check.dup
  architectures_to_check.each do |arch|
    builds_needed.delete(arch) if remote_binary[arch.to_sym]
    puts "builds_needed for #{name} is now #{builds_needed}" if VERBOSE
  end
  return builds_needed
end

def update_hashes_and_manifests(name = nil)
  unless CREW_BUILD_NO_PACKAGE_FILE_HASH_UPDATES
    remote_binary = { armv7l: nil, i686: nil, x86_64: nil }
    remote_binary.keys.each do |arch|
      arch_specific_url = "#{CREW_GITLAB_PKG_REPO}/generic/#{name}/#{@pkg_obj.version}_#{arch}/#{name}-#{@pkg_obj.version}-chromeos-#{arch}.#{@pkg_obj.binary_compression}"
      puts "Checking: curl -sI #{arch_specific_url}" if VERBOSE
      remote_binary[arch.to_sym] = `curl -sI #{arch_specific_url}`.lines.first.split[1] == '200'
      puts "#{arch_specific_url} found!" if remote_binary[arch.to_sym] && VERBOSE
    end
    # Add build hashes.
    system "crew update_package_file #{name}" unless remote_binary.values.all?(nil)
    # Add manifests if we are in the right architecture.
    if @pkg_obj.compatibility == 'all' || @pkg_obj.compatibility.include?(ARCH)
      # Using crew reinstall -f package here updates the hashes for
      # binaries.
      if system("yes | crew reinstall --regenerate-filelist #{'-f' unless CREW_BUILD_NO_PACKAGE_FILE_HASH_UPDATES} #{name}") && File.exist?("#{CREW_META_PATH}/#{name}.filelist") && File.directory?(CREW_LOCAL_REPO_ROOT)
        puts 'Adding manifests...'
        FileUtils.cp "#{CREW_META_PATH}/#{name}.filelist", "#{CREW_LOCAL_REPO_ROOT}/manifest/#{ARCH}/#{name.chr}/#{name}.filelist"
      end
    else
      puts "Package #{name} is not compatible with your device architecture (#{ARCH}). Manifests will not be added.".orange
      return
    end
  end
end

def update_deps(name = nil)
  unless CREW_BUILD_NO_PACKAGE_FILE_HASH_UPDATES
    # Update package dependencies.
    if @pkg_obj.compatibility == 'all' || @pkg_obj.compatibility.include?(ARCH)
      Kernel.system "tools/getrealdeps.rb #{name}"
    else
      puts "Package #{name} is not compatible with your device architecture (#{ARCH}). Dependencies will not be checked.".orange
    end
  end
end

def determine_recursive_deps(d_pkg_input)
  # How to hardcode a dependency:
  # @gcc_lib_graph = Dagwood::DependencyGraph.new(gcc_lib: %i[glibc])
  # @glibc_graph = Dagwood::DependencyGraph.new(glibc: nil)
  # @gcc_lib_graph.merge(@glibc_graph)
  if d_pkg_input.is_a? String
    (d_pkgs ||= []).push(d_pkg_input)
  else
    ((d_pkgs ||= []) << d_pkg_input).flatten!
  end
  d_pkgs.each do |d_pkg|
    # Remove glibc from the dependency list to avoid a circular dependency with libxcrypt.
    instance_variable_set("@#{d_pkg}_deps", `ruby bin/crew -d deps --exclude-buildessential #{d_pkg}`.split.delete_if { |d| d == 'glibc' })
    # Pull in build dependencies if necessary.
    if d_pkg.include?('_lib') || d_pkg.include?('_dev')
      puts "#{"#{__LINE__}:" if CREW_VERBOSE} #{d_pkg} includes _dev || _lib, pulling build deps.".orange
      instance_variable_set("@#{d_pkg}_deps", `ruby bin/crew -d deps -b --exclude-buildessential #{d_pkg}`.split.delete_if { |d| d == 'glibc' })
    end
    instance_variable_set("@#{d_pkg}_graph", Dagwood::DependencyGraph.new({ d_pkg.to_sym => (instance_variable_get("@#{d_pkg}_deps").map &:to_sym) })) if instance_variable_get("@#{d_pkg}_graph").nil?

    next unless !instance_variable_get("@#{d_pkg}_graph").nil? && !instance_variable_get("@#{d_pkg}_graph").dependencies.nil?

    next if instance_variable_get("@#{d_pkg}_deps").empty?
    instance_variable_get("@#{d_pkg}_deps").each do |d|
      determine_recursive_deps(d) if instance_variable_get("@#{d}_graph").nil?
      instance_variable_set("@#{d_pkg}_graph", instance_variable_get("@#{d_pkg}_graph").merge(instance_variable_get("@#{d}_graph"))) unless instance_variable_get("@#{d}_graph").dependencies.nil?
    end
  end
end

def print_recursive_deps(d_pkg_input)
  if d_pkg_input.is_a? String
    (d_pkgs ||= []).push(d_pkg_input)
  else
    ((d_pkgs ||= []) << d_pkg_input).flatten!
  end
  d_pkgs.each do |p|
    abort "@#{p}_graph does not exist!".lightred unless !instance_variable_get("@#{p}_graph").nil? && !instance_variable_get("@#{p}_graph").dependencies.nil?
    deps = instance_variable_get("@#{p}_graph").dependencies
    puts deps.to_s.lightblue
    begin
      puts instance_variable_get("@#{p}_graph").order
    rescue RuntimeError => e
      puts e.message.lightred
    rescue TSort::Cyclic => e
      puts "Circular dependency detected: #{e.message}".lightred
    end
  end
end

def order_recursive_deps(d_pkg_input)
  if d_pkg_input.is_a? String
    (d_pkgs ||= []).push(d_pkg_input)
  else
    ((d_pkgs ||= []) << d_pkg_input).flatten!
  end
  puts "#{"#{__LINE__}:" if CREW_VERBOSE} Processing dependencies...".lightpurple
  determine_recursive_deps(d_pkgs)
  @input_pkgs = d_pkgs.to_set
  merge_base = instance_variable_get("@#{d_pkgs.pop}_graph")

  d_pkgs.each do |p|
    merge_base = merge_base.merge(instance_variable_get("@#{p}_graph"))
  end
  @package_deps_build_order = merge_base.order.to_set(&:to_s)
  # Want the intersection of these sets.
  # puts (@package_deps_build_order & @input_pkgs).to_a
  return (@package_deps_build_order & @input_pkgs).to_a
end

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
  updated_packages.push(*changed_files.select { |c| c.include?('packages/') })
  updated_packages.push(*changed_files_previous_commit.select { |c| c.include?('packages/') })
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
  puts 'These packages will be checked to see if they need updated binaries:'.orange
  updated_packages.uniq!
  updated_packages.each { |p| puts p.sub('packages/', '').sub('.rb', '').to_s.lightblue }
end

updated_packages = determine_recursive_deps(updated_packages.map { |p| p.sub('packages/', '').sub('.rb', '') }).map { |p| p.prepend('packages/').concat('.rb') }

updated_packages.each do |pkg|
  name = pkg.sub('packages/', '').sub('.rb', '')
  next unless File.file?(pkg)

  puts "Evaluating #{name} package...".lightpurple
  system "rubocop -c .rubocop.yml -A #{pkg}"
  @pkg_obj = Package.load_package(pkg)

  # Handle case of no_compile_needed ruby gems actually containing
  # libraries requiring compiles, in which which case we need to disable
  # no_compile_needed and add gem_compile_needed, which the ruby
  # buildsystem will add.
  if @pkg_obj.superclass.to_s == 'RUBY' && @pkg_obj.no_compile_needed?
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
  if !system("grep -q binary_sha256 #{pkg}") && !@pkg_obj.no_compile_needed? && !@pkg_obj.gem_compile_needed?
    puts "#{name.capitalize} #{@pkg_obj.version} has no binaries and may not need them.".lightgreen
    next pkg
  elsif @pkg_obj.no_compile_needed? && (@pkg_obj.compatibility == 'all' || @pkg_obj.compatibility.include?(ARCH))
    # Using crew reinstall -f package here updates the hashes for
    # binaries.
    system "yes | crew reinstall #{'-f' unless CREW_BUILD_NO_PACKAGE_FILE_HASH_UPDATES} #{name}"
    # Add manifests if we are in the right architecture.
    if system("yes | crew reinstall #{'-f' unless CREW_BUILD_NO_PACKAGE_FILE_HASH_UPDATES} #{name}") && File.exist?("#{CREW_META_PATH}/#{name}.filelist") && File.directory?(CREW_LOCAL_REPO_ROOT)
      puts 'Adding manifests.'
      FileUtils.cp "#{CREW_META_PATH}/#{name}.filelist", "#{CREW_LOCAL_REPO_ROOT}/manifest/#{ARCH}/#{name.chr}/#{name}.filelist"
    end
  else
    if @pkg_obj.no_binaries_needed?
      puts "no binaries needed for #{pkg}"
      updated_packages.delete(pkg)
      next
    end
    architectures_to_check = @pkg_obj.compatibility == 'all' ? %w[x86_64 armv7l i686] : @pkg_obj.compatibility.delete(',').split
    puts "#{name.capitalize} appears to need binaries. Checking to see if current binaries exist...".orange
    builds_needed = check_build_uploads(architectures_to_check, name)
    if builds_needed.empty?
      puts "No builds are needed for #{name} #{@pkg_obj.version}.".lightgreen
      update_hashes_and_manifests(name)
      update_deps(name)
      puts "Copying #{File.join(CREW_PACKAGES_PATH, pkg.sub('packages/', ''))} to #{pkg}".lightblue
      FileUtils.cp File.join(CREW_PACKAGES_PATH, pkg.sub('packages/', '')), pkg
      next
    else
      puts "#{name.capitalize} #{@pkg_obj.version} needs builds uploaded for: #{builds_needed.join(' ')}".lightblue

      if builds_needed.include?(ARCH) && !File.file?("release/#{ARCH}/#{name}-#{@pkg_obj.version}-chromeos-#{ARCH}.#{@pkg_obj.binary_compression}") && agree_default_yes("\nWould you like to build #{name} #{@pkg_obj.version}")
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
        system "yes | #{'CREW_CACHE_BUILD=1' if ENV['NESTED_CI']} nice -n 20 crew build -v -f #{pkg}"
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
        upload_pkg = true if File.file?("release/#{build}/#{name}-#{@pkg_obj.version}-chromeos-#{build}.#{@pkg_obj.binary_compression}")
      end
      system('yes | crew reinstall py3_twine', %i[out err] => File::NULL) unless system('twine --help', %i[out err] => File::NULL)
      system "crew upload -v #{name}" if upload_pkg == true && agree_default_yes("\nWould you like to upload #{name} #{@pkg_obj.version}")
      system "rubocop -c .rubocop.yml -A #{pkg}"
      puts "Are builds still needed for #{name}?".orange
      builds_still_needed = check_build_uploads(architectures_to_check, name)
      puts "Built and Uploaded: #{name} for #{ARCH}" if builds_needed != builds_still_needed
      # next if builds_still_needed.empty? && system("grep -q binary_sha256 #{pkg}")
      next if builds_still_needed.empty?

      puts "#{name.capitalize} #{@pkg_obj.version} still needs builds uploaded for: #{builds_still_needed.join(' ')}".lightblue unless builds_still_needed.empty? && system("grep -q binary_sha256 #{pkg}")
      puts "#{name.capitalize} #{@pkg_obj.version} still needs build sha256 hashes added.".lightblue unless system("grep -q binary_sha256 #{pkg}")
    end
  end
end
