#!/usr/local/bin/ruby
# build_updated_packages version 2.7 (for Chromebrew)
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
require_relative '../lib/color'
require_relative '../lib/const'
require_relative '../lib/package'
require_relative '../lib/require_gem'
$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

abort "\nGITLAB_TOKEN environment variable not set.\n".lightred if ENV['GITLAB_TOKEN'].nil?
abort "\nGITLAB_TOKEN_USERNAME environment variable not set.\n".lightred if ENV['GITLAB_TOKEN_USERNAME'].nil?
puts "Setting the CREW_AGREE_TIMEOUT_SECONDS environment variable to less than the default of #{CREW_AGREE_TIMEOUT_SECONDS} may speed this up...".orange if ENV['CREW_AGREE_TIMEOUT_SECONDS'].nil?

CONTINUE_AFTER_FAILED_BUILDS = ARGV.include?('--continue-after-failed-builds')
SKIP_UPDATE_CHECKS = ARGV.include?('--skip')
CHECK_ALL_PYTHON = ARGV.include?('--check-all-python')
CHECK_ALL_RUBY = ARGV.include?('--check-all-ruby')
require_gem 'highline'
require_gem 'timeout'

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
  binary_sha256_hash = { armv7l: nil, i686: nil, x86_64: nil }
  builds_needed = architectures_to_check.dup
  architectures_to_check.each do |arch|
    arch_specific_url = "#{CREW_GITLAB_PKG_REPO}/generic/#{name}/#{@pkg_obj.version}_#{arch}/#{name}-#{@pkg_obj.version}-chromeos-#{arch}.#{@pkg_obj.binary_compression}"
    puts "Checking: curl -sI #{arch_specific_url}" if CREW_VERBOSE
    if `curl -sI #{arch_specific_url}`.lines.first.split[1] == '200'
      # Check build hashes if we are in the right architecture.
      if arch == ARCH
        binary_sha256_hash[arch.to_sym] = @pkg_obj.binary_sha256[arch.to_sym]
        puts "Package hash is #{binary_sha256_hash[arch.to_sym]}" if CREW_VERBOSE
        @remote_hash = `curl -Ls #{arch_specific_url} | sha256sum -`.lines.first.split[0]
        puts "Remote hash is #{@remote_hash}" if CREW_VERBOSE
        unless @remote_hash == binary_sha256_hash[arch.to_sym]
          puts "#{arch}/#{name}: Adjusting sha256sum in package file to the remote binary sha256sum".lightpurple
          puts "#{binary_sha256_hash[arch.to_sym]} =>\n#{@remote_hash}".blue
          system "sed -i 's,#{binary_sha256_hash[arch.to_sym]},#{@remote_hash},g' packages/#{name}.rb"
          # Do a force install to make sure the package hashes are ok.
          puts "Checking install of #{name} to confirm binary hashes are correct.".lightpurple
          system "yes | crew install -f #{name} ; crew remove #{name}", exception: false
        end
      end
      builds_needed.delete(arch)
      puts "#{arch_specific_url} found!" if CREW_VERBOSE
    end
    puts "builds_needed for #{name} is now #{builds_needed}" if CREW_VERBOSE
  end
  return builds_needed
end

if SKIP_UPDATE_CHECKS
  puts 'Skipping pip and gem remote update checks.'.orange
else
  puts 'Checking for pip package version updates...'.orange
  Kernel.system 'tools/update_python_pip_packages.rb'
  puts 'Checking for ruby gem package version updates...'.orange
  Kernel.system 'tools/update_ruby_gem_packages.rb'
end
changed_files = `git diff HEAD --name-only`.chomp.split
changed_files_previous_commit = `git diff-tree --no-commit-id --name-only -r $(git rev-parse origin/master)..$(git rev-parse --verify HEAD)`.chomp.split
updated_packages = changed_files.select { |c| c.include?('packages/') }
updated_packages.push(*changed_files_previous_commit.select { |c| c.include?('packages/') })

if updated_packages.empty?
  puts 'No packages need to be updated.'.orange
else
  puts 'These changed packages will be checked to see if they need updated binaries:'.orange
  updated_packages.uniq!
  updated_packages.each { |p| puts p.sub('packages/', '').sub('.rb', '').to_s.lightblue }
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

updated_packages.each do |pkg|
  name = pkg.sub('packages/', '').sub('.rb', '')
  next unless File.file?(pkg)

  puts "Evaluating #{name} package...".orange
  @pkg_obj = Package.load_package(pkg)

  # Don't check if we need new binaries if the package doesn't already
  # have binaries for this architecture and no_compile_needed is set.
  if !system("grep -q binary_sha256 #{pkg}") && @pkg_obj.no_compile_needed?
    puts "#{name.capitalize} #{@pkg_obj.version} has no binaries and may not need them.".lightgreen
    next pkg
  else
    if @pkg_obj.no_binaries_needed?
      updated_packages.delete(pkg)
      next
    end
    architectures_to_check = @pkg_obj.compatibility == 'all' ? %w[x86_64 armv7l i686] : @pkg_obj.compatibility.delete(',').split
    puts "#{name.capitalize} appears to need binaries. Checking to see if current binaries exist...".orange
    builds_needed = check_build_uploads(architectures_to_check, name)
    if builds_needed.empty?
      puts "No builds are needed for #{name} #{@pkg_obj.version}.".lightgreen
      next
    else
      puts "#{name.capitalize} #{@pkg_obj.version} needs builds uploaded for: #{builds_needed.join(' ')}".lightblue

      if builds_needed.include?(ARCH) && !File.file?("release/#{ARCH}/#{name}-#{@pkg_obj.version}-chromeos-#{ARCH}.#{@pkg_obj.binary_compression}") && agree_default_yes("\nWould you like to build #{name} #{@pkg_obj.version}")
        system "yes | nice -n 20 crew build -f #{pkg}"
        unless $CHILD_STATUS.success?
          if CONTINUE_AFTER_FAILED_BUILDS
            puts "#{pkg} build failed!".lightred
            next
          else
            abort "#{pkg} build failed!".lightred
          end
        end
        # Reinvoke this script to take just built packages that have been built and
        # installed into account, attempting uploads of just built packages immediately.
        cmdline = "cd #{`pwd`.chomp} && crew upload #{name} ; #{$PROGRAM_NAME} #{ARGV.join(' ')}"
        puts "cmdline is #{cmdline}"
        exec cmdline
      end
      upload_pkg = nil
      builds_needed.each do |build|
        upload_pkg = true if File.file?("release/#{build}/#{name}-#{@pkg_obj.version}-chromeos-#{build}.#{@pkg_obj.binary_compression}")
      end
      system('yes | crew reinstall py3_twine', %i[out err] => File::NULL) unless system('twine --help', %i[out err] => File::NULL)
      system "crew upload #{name}" if upload_pkg == true && agree_default_yes("\nWould you like to upload #{name} #{@pkg_obj.version}")
      puts "Are builds still needed for #{name}?".orange
      builds_still_needed = check_build_uploads(architectures_to_check, name)
      puts "Built and Uploaded: #{name} for #{ARCH}" if builds_needed != builds_still_needed
      next if builds_still_needed.empty? && system("grep -q binary_sha256 #{pkg}")

      puts "#{name.capitalize} #{@pkg_obj.version} still needs builds uploaded for: #{builds_still_needed.join(' ')}".lightblue unless builds_still_needed.empty? && system("grep -q binary_sha256 #{pkg}")
      puts "#{name.capitalize} #{@pkg_obj.version} still needs build sha256 hashes added.".lightblue unless system("grep -q binary_sha256 #{pkg}")
    end
  end
end
