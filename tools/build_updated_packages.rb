#!/usr/bin/env ruby
# build_updated_packages version 1.3 (for Chromebrew)
# This updates the versions in python pip packages by calling
# tools/update_python_pip_packages.rb, checks for updated ruby packages
# by calling tools/update_ruby_gem_packages.rb, and then checks if any
# packages have been updated that need updated binaries. If so, it tries
# to build those binaries.
#
# Author: Satadru Pramanik (satmandu) satadru at gmail dot com
# Usage in root of cloned chromebrew repo:
# tools/build_updated_packages.rb

require_relative '../lib/color'
require_relative '../lib/const'

abort "\nGITLAB_TOKEN environment variable not set.\n".lightred if ENV['GITLAB_TOKEN'].nil?
abort "\nGITLAB_TOKEN_USERNAME environment variable not set.\n".lightred if ENV['GITLAB_TOKEN_USERNAME'].nil?
puts "Setting the CREW_AGREE_TIMEOUT_SECONDS environment variable to less than the default of #{CREW_AGREE_TIMEOUT_SECONDS} may speed this up...".orange if ENV['CREW_AGREE_TIMEOUT_SECONDS'].nil?

SKIP_UPDATE_CHECKS = ARGV.include?('--skip')
def require_gem(gem_name_and_require = nil, require_override = nil)
  # Allow only loading gems when needed.
  return if gem_name_and_require.nil?

  gem_name = gem_name_and_require.split('/')[0]
  begin
    gem gem_name
  rescue LoadError
    puts " -> install #{gem_name} gem".orange
    Gem.install(gem_name)
    gem gem_name
  end
  requires = if require_override.nil?
               gem_name_and_require.split('/')[1].nil? ? gem_name_and_require.split('/')[0] : gem_name_and_require
             else
               require_override
             end
  require requires
end
require_gem 'highline'
require_gem 'timeout'

# The following is from lib/package_helpers.rb
def property(*properties)
  properties.flatten!
  # property: like attr_accessor, but `=` is not needed to define a value
  # Examples:
  #   {prop_name}('example') # set {prop_name} to 'example'
  #   {prop_name}            # return the value of {prop_name}
  define_singleton_method(:available_properties) do
    # available__properties: Return all available properties for use in commands/{prop,help}.rb
    # Usage:
    #   puts Package.available_properties => [:conflicts_ok, ...]
    return properties
  end

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
  boolean_properties.flatten!
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

# This is from lib/package.rb:
def agree_with_default(yes_or_no_question_msg, character = nil, default:)
  yes_or_no_question = yes_or_no_question_msg.lightpurple
  answer_type = ->(yn) { yn.downcase[0] == 'y' || (yn.empty? && default.downcase[0] == 'y') }

  HighLine.ask(yes_or_no_question, answer_type) do |q|
    q.validate                 = /\A(?:y(?:es)?|no?|)\Z/i
    q.responses[:not_valid]    = 'Please enter "yes" or "no".'
    q.responses[:ask_on_error] = :question
    q.character                = character
    q.completion               = %w[yes no]

    yield q if block_given?
  end
end

def self.agree_default_yes(message = nil)
  Timeout.timeout(CREW_AGREE_TIMEOUT_SECONDS) do
    return agree_with_default("#{message} (YES/no)?", true, default: 'y')
  end
rescue Timeout::Error
  return true
end

# Get all boolean properties from package.rb
boolean_properties = `sed -n '/^\ \ boolean_property/,/^$/p' lib/package.rb | sed 's/^\ \ boolean_property//' | tr -d '\n' | sort -u`.chomp.delete(',').delete(':').split.join(' ')
boolean_property(boolean_properties.split)

# Get all other properties from buildsystems files and package.rb
buildsystem_properties = `sed -n '/^\ \ property/,/^$/p' lib/buildsystems/* | sed 's/^\ \ property//' | tr -d '\n' | sort -u`.chomp.delete(',').delete(':').split.join(' ')
package_properties = `sed -n '/^\ \ property/,/^$/p' lib/package.rb | sed 's/^\ \ property//' | tr -d '\n' | sort -u`.chomp.delete(',').delete(':').split.join(' ')
properties = "#{package_properties} #{buildsystem_properties}"
property(properties.split)

if SKIP_UPDATE_CHECKS
  puts 'Skipping pip and gem remote update checks.'.orange
else
  puts 'Checking for pip package version updates...'.orange
  load 'tools/update_python_pip_packages.rb'
  puts 'Checking for ruby gem package version updates...'.orange
  load 'tools/update_ruby_gem_packages.rb'
end
changed_files = `git diff HEAD --name-only`.chomp.split
updated_packages = changed_files.select { |c| c.include?('packages/') }

if updated_packages.empty?
  puts 'No packages need to be updated.'.orange
else
  puts 'These changed packages will be checked to see if they need updated binaries:'.orange
  updated_packages.each { |p| puts p.sub('packages/', '').sub('.rb', '').to_s.lightblue }
end

updated_packages.each do |pkg|
  name = pkg.sub('packages/', '').sub('.rb', '')

  puts "Evaluating #{name} package...".orange
  # rubocop:disable Security/Eval
  eval(`sed -e '/^require/d' -e '/^\ \ depends_on/d' -e '/^class/d' -e '/^end/d' #{pkg}`.chomp)
  # rubocop:enable Security/Eval
  boolean_property(boolean_properties.split)
  property(properties.split)

  # Don't check if we need new binaries if the package doesn't already
  # have binaries for this architecture and no_compile_needed is set.
  if !system("grep -q binary_sha256 #{pkg}") && no_compile_needed?
    puts "#{name.capitalize} #{@version} has no binaries and may not need them.".lightgreen
    next pkg
  else
    check_builds = compatibility == 'all' ? %w[x86_64 armv7l i686] : compatibility.split
    check_builds.delete('aarch64')
    build = check_builds.dup
    check_builds.each do |arch|
      arch_specific_url = "#{CREW_GITLAB_PKG_REPO}/generic/#{name}/#{@version}_#{arch}/#{name}-#{@version}-chromeos-#{arch}.tar.zst"
      build.delete(arch) if `curl -sI #{arch_specific_url}`.lines.first.split[1] == '200'
    end
    if build.empty?
      puts "No builds are needed for #{name} #{@version}.".lightgreen
      next
    else
      puts "#{name.capitalize} #{@version} needs builds uploaded for: #{build.join(' ')}".lightblue
    end
    if build.include?(ARCH) && agree_default_yes("\nWould you like to build #{name} #{@version}")
      system "yes | crew build -f #{pkg}"
      system "crew upload #{name}"
    end
  end
end
