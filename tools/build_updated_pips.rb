#!/usr/bin/env ruby
# build_updated_pips version 1.0 (for Chromebrew)
# This updates the versions in python pip packages by calling
# tools/update_pythin_pip_packages.rb and then checks if any packages
# have been updated, and if so, if they need updated binaries.
# If so, it tries to build those binaries.
#
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in root of cloned chromebrew repo: ../tools/build_updated_pips.rb
require_relative '../lib/color'
require_relative '../lib/const'

# The following is just cripped from lib/package_helpers.
def property(*properties)
  # property: like attr_accessor, but `=` is not needed to define a value
  # Examples:
  #   {prop_name}('example') # set {prop_name} to 'example'
  #   {prop_name}            # return the value of {prop_name}
  properties.each do |prop_name|
    define_singleton_method(prop_name) do |prop_value = nil, &block|
      prop_var_name = "@#{prop_name}"

      if block
        # store the block if a block is provided
        instance_variable_set(prop_var_name, block)
      elsif prop_value
        instance_variable_set(prop_var_name, prop_value)
      else
        # return current value if nothing is provided
        return instance_variable_get(prop_var_name)
      end
    end
  end
end

def boolean_property(*boolean_properties)
  # boolean_property: if this exists in a package, it will return true
  # Examples:
  #   {prop_name}            # this will return #{prop_name} as true

  define_singleton_method(:available_boolean_properties) do
    # available_boolean_properties: Return all available boolean properties for use in commands/{prop,help}.rb
    # Usage:
    #   puts Package.available_boolean_properties => [:conflicts_ok, ...]
    return boolean_properties
  end

  boolean_properties.each do |prop_name|
    prop_var_name = "@#{prop_name}"

    # Adds the self.{symbol} method
    define_singleton_method(prop_name) do
      instance_variable_set(prop_var_name, true)
    end

    # Adds the self.{symbol}? method
    define_singleton_method("#{prop_name}?") do
      return !!instance_variable_get(prop_var_name)
    end
  end
end

boolean_property :arch_flags_override, :conflicts_ok, :git_clone_deep, :git_fetchtags, :gnome, :is_fake, :is_musl, :is_static,
                 :no_compile_needed, :no_compress, :no_env_options, :no_fhs, :no_git_submodules, :no_links, :no_lto, :no_patchelf,
                 :no_shrink, :no_source_build, :no_strip, :no_upstream_update, :no_zstd, :patchelf, :prerelease, :print_source_bashrc, :run_tests

property :description, :homepage, :version, :license, :compatibility,
         :binary_compression, :binary_url, :binary_sha256, :source_url, :source_sha256,
         :git_branch, :git_hashtag, :max_glibc, :min_glibc, :pip_install_extras, :pre_configure_options

puts 'Checking for pip package version updates...'.orange
system '../tools/update_python_pip_packages.rb', chdir: 'packages'
changed_packages = `git diff HEAD --name-only`.chomp.split.join(' ')
changed_pip_packages = `grep -l "^require 'buildsystems/pip'" #{changed_packages}`.chomp.split
puts 'No pip packages need to be updated.'.orange if changed_pip_packages.empty?

base_url = 'https://gitlab.com/api/v4/projects/26210301/packages'
changed_pip_packages.each do |pkg|
  # rubocop:disable Security/Eval
  eval(`sed -e '/require/d' -e '/depends_on/d' -e '/^class/d' -e '/^end/d' #{pkg}`.chomp)
  # rubocop:enable Security/Eval

  # Don't check if we need new binaries if the package doesn't already
  # have binaries for this architecture.
  next pkg if @binary_sha256.nil?

  next unless @binary_sha256.key?(ARCH.to_sym)

  name = pkg.sub('packages/', '').sub('.rb', '')

  new_url = "#{base_url}/generic/#{name}/#{@version}_#{ARCH}/#{name}-#{@version}-chromeos-#{ARCH}.tar.zst"

  if `curl -sI #{new_url}`.lines.first.split[1] == '200'
    puts "#{pkg} already uploaded."
  else
    puts "#{pkg} needs rebuilding"
    system "yes | crew build -f #{pkg}"
    system "crew upload #{name}"
  end
end
