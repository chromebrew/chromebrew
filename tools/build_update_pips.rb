#!/bin/env ruby
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
                 :no_shrink, :no_source_build, :no_strip, :no_upstream_update, :no_zstd, :patchelf, :print_source_bashrc, :run_tests

property :description, :homepage, :version, :license, :compatibility,
         :binary_compression, :binary_url, :binary_sha256, :source_url, :source_sha256,
         :git_branch, :git_hashtag, :max_glibc, :min_glibc, :pip_install_extras, :pre_configure_options

changed_packages = `git diff HEAD --name-only`.chomp.split.join(' ')
changed_pip_packages = `grep -l "^require 'buildsystems/pip'" #{changed_packages}`.chomp.split
pip_cache_dir = `pip cache dir`.chomp

base_url = 'https://gitlab.com/api/v4/projects/26210301/packages/generic'
installed_pips = false
changed_pip_packages.each do |pkg|
  # pkg_file = `sed -e '/require/d' -e '/depends_on/d' -e '/^class/d' -e '/^end/d' #{pkg}`.chomp
  eval(`sed -e '/require/d' -e '/depends_on/d' -e '/^class/d' -e '/^end/d' #{pkg}`.chomp)

  # Don't check if we need new binaries if the package doesn't already
  # have binaries for this architecture.
  next pkg if @binary_sha256.nil?

  next unless @binary_sha256.key?(ARCH.to_sym)

  name = pkg.sub('packages/', '').sub('.rb', '')

  new_url = "#{base_url}/#{name}/#{@version}_#{ARCH}/#{name}-#{@version}-chromeos-#{ARCH}.tar.zst"

  if `curl -sI #{new_url}`.lines.first.split[1] == '200'
    puts "#{pkg} already uploaded."
  else
    puts "#{pkg} needs rebuilding"
    Kernel.system "yes | crew build -f #{pkg}"
    installed_pips = true
  end
end
if installed_pips
  # Twine 5.1.1 currently breaks on some uploads.
  # Install twine from https://github.com/pypa/twine/pull/1123 until
  # that is fixed.
  Kernel.system('yes | crew install py3_twine')
  pip_config = `pip config list`.chomp
  Kernel.system 'pip config --user set global.index-url https://gitlab.com/api/v4/projects/26210301/packages/pypi/simple', %i[err out] => File::NULL unless pip_config.include?("global.index-url='https://gitlab.com/api/v4/projects/26210301/packages/pypi/simple'")
  Kernel.system 'pip config --user set global.extra-index-url https://pypi.org/simple', %i[err out] => File::NULL unless pip_config.include?("global.extra-index-url='https://pypi.org/simple'")
  Kernel.system 'pip config --user set global.trusted-host gitlab.com', %i[err out] => File::NULL unless pip_config.include?("global.trusted-host='gitlab.com'")

  # Kernel.system('pip install git+https://github.com/pypa/twine.git@bugfix/1116-pkginfo-warnings')
  pip_platform = `python -c "import platform;print(platform.system().lower() + '_' + platform.machine())"`.chomp
  wheels = `find #{pip_cache_dir} -type f \\( -name \"*#{pip_platform}.whl\" -o -name \"*-any.whl\" \\) -print`.chomp.split
  puts "Found wheels: #{wheels}"
  wheels.each do |wheel|
    puts "Uploading #{wheel}"
    FileUtils.rm_f wheel if system "twine upload --repository gitlab #{wheel}"
  end
end
