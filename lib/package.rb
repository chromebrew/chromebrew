require 'English'
require_relative 'const'
require_relative 'color'
require_relative 'package_helpers'
require_relative 'selector'

class Package
  property :description, :homepage, :version, :license, :compatibility,
           :binary_url, :binary_sha256, :source_url, :source_sha256,
           :git_branch, :git_hashtag

  boolean_property :conflicts_ok, :git_clone_deep, :git_fetchtags, :gnome, :is_fake, :is_musl, :is_static,
                   :no_compile_needed, :no_compress, :no_env_options, :no_fhs, :no_git_submodules,
                   :no_links, :no_lto, :no_patchelf, :no_shrink, :no_strip, :no_zstd, :patchelf, :run_tests

  create_placeholder :preflight,   # Function for checks to see if install should occur.
                     :patch,       # Function to perform patch operations prior to build from source.
                     :prebuild,    # Function to perform pre-build operations prior to build from source.
                     :build,       # Function to perform build from source.
                     :postbuild,   # Function to perform post-build for both source build and binary distribution.
                     :check,       # Function to perform check from source build. (executes only during `crew build`)
                     :preinstall,  # Function to perform pre-install operations prior to install.
                     :install,     # Function to perform install from source build.
                     :postinstall, # Function to perform post-install for both source build and binary distribution.
                     :preremove,   # Function to perform prior to package removal.
                     :remove       # Function to perform after package removal.

  class << self
    attr_accessor :name, :cached_build, :in_build, :build_from_source, :in_upgrade
  end

  def self.load_package(pkgFile, pkgName = File.basename(pkgFile, '.rb'))
    # self.load_package: load a package under 'Package' class scope
    #
    className = pkgName.capitalize

    # read and eval package script under 'Package' class
    class_eval(File.read(pkgFile, encoding: Encoding::UTF_8), pkgFile) unless const_defined?("Package::#{className}")

    pkgObj = const_get(className)
    pkgObj.name = pkgName

    @crew_current_package = @crew_current_package.nil? ? pkgObj.name : @crew_current_package

    return pkgObj
  end

  def self.dependencies
    # We need instance variable in derived class, so not define it here,
    # base class.  Instead of define it, we initialize it in a function
    # called from derived classees.
    @dependencies ||= {}
  end

  def self.get_deps_list(pkgName = name, return_attr: false, hash: false, include_build_deps: 'auto', include_self: false,
                         pkgTags: [], verCheck: nil, highlight_build_deps: true, exclude_buildessential: false, top_level: true)
    # get_deps_list: get dependencies list of pkgName (current package by default)
    #
    #                pkgName: package to check dependencies, current package by default
    #            return_attr: return package attribute (tags and version lambda) also
    #                   hash: return result in nested hash, used by `print_deps_tree` (`bin/crew`)
    #
    #     include_build_deps: if set to true, force all build dependencies to be returned.
    #                         if set to false, all build dependencies will not be returned
    #                         if set to "auto" (default), return build dependencies if pre-built binaries not available
    #
    #           include_self: include #{pkgName} itself in returned result, only used in recursive calls (see `expandedDeps` below)
    #   highlight_build_deps: include corresponding symbols in return value, you can convert it to actual ascii color codes later
    # exclude_buildessential: do not insert `buildessential` dependency automatically
    #
    #              top_level: if set to true, return satisfied dependencies
    #                         (dependencies that might be a sub-dependency of a dependency that checked before),
    #                         always set to false if this function is called in recursive loop (see `expandedDeps` below)
    #
    @checked_list ||= {} # create @checked_list placeholder if not exist

    # add current package to @checked_list for preventing extra checks
    @checked_list.merge!({ pkgName => pkgTags })

    pkgObj = load_package("#{CREW_PACKAGES_PATH}/#{pkgName}.rb")
    is_source = pkgObj.is_source?(ARCH.to_sym) or pkgObj.build_from_source
    deps = pkgObj.dependencies

    # append buildessential to deps if building from source is needed/specified
    if ((include_build_deps == true) || ((include_build_deps == 'auto') && is_source)) && \
       !pkgObj.no_compile_needed? && \
       !exclude_buildessential && \
       !@checked_list.keys.include?('buildessential')

      deps = { 'buildessential' => [[:build]] }.merge(deps)
    end

    # parse dependencies recursively
    expandedDeps = deps.uniq.map do |dep, (depTags, verCheck)|
      # check build dependencies only if building from source is needed/specified
      # Do not recursively find :build based build dependencies.
      next unless (include_build_deps == true && @crew_current_package == pkgObj.name) || \
                  ((include_build_deps == 'auto') && is_source && @crew_current_package == pkgObj.name) || \
                  !depTags.include?(:build)

      # overwrite tags if parent dependency is a build dependency
      # (for build dependencies highlighting)
      tags = pkgTags.include?(:build) ? pkgTags : depTags

      if @checked_list.keys.none?(dep)
        # check dependency by calling this function recursively
        next \
          send(
            __method__, dep, pkgTags: tags, verCheck:, include_self: true, top_level: false,
            hash:, return_attr:, include_build_deps:, highlight_build_deps:, exclude_buildessential:
          )
      elsif hash && top_level
        # will be dropped here if current dependency is already checked and #{top_level} is set to true
        #
        # the '+' symbol tell `print_deps_tree` (`bin/crew`) to color this package as "satisfied dependency"
        # the '*' symbol tell `print_deps_tree` (`bin/crew`) to color this package as "build dependency"
        if highlight_build_deps && tags.include?(:build)
          next { "+*#{dep}*+" => [] }
        elsif highlight_build_deps
          next { "+#{dep}+" => [] }
        else
          next { dep => [] }
        end
      end
    end.compact

    if hash
      # the '*' symbol tell `print_deps_tree` (`bin/crew`) to color this package as "build dependency"
      if highlight_build_deps && pkgTags.include?(:build)
        return { "*#{pkgName}*" => expandedDeps }
      else
        return { pkgName => expandedDeps }
      end
    elsif include_self
      # return pkgName itself if this function is called as a recursive loop (see `expandedDeps`)
      if return_attr
        return [expandedDeps, { pkgName => [pkgTags, verCheck] }].flatten
      else
        return [expandedDeps, pkgName].flatten
      end
    else
      # if this function is called outside of this function, return parsed dependencies only
      return expandedDeps.flatten
    end
  end

  def self.compatible?
    if @compatibility
      return (@compatibility.casecmp?('all') || @compatibility.include?(ARCH))
    else
      warn "#{name}: Missing `compatibility` field.".lightred
      return false
    end
  end

  def self.depends_on(dependency, ver_range = nil)
    @dependencies ||= {}
    ver_check = nil
    dep_tags  = []

    # add element in "[ name, [ tag1, tag2, ... ] ]" format
    if dependency.is_a?(Hash)
      # parse "depends_on name => <tags: Symbol|Array>"
      depName, tags = dependency.first

      # convert `tags` to array in case `tags` is a symbol
      dep_tags += [tags].flatten
    else
      # parse "depends_on name"
      depName = dependency
    end

    # process dependency version range if specified
    # example:
    #   depends_on name, '>= 1.0'
    #
    # operator can be '>=', '==', '<=', '<', '>'
    if ver_range
      operator, target_ver = ver_range.split(' ', 2)

      # lambda for comparing the given range with installed version
      ver_check = lambda do |installed_ver|
        unless Gem::Version.new(installed_ver).send( operator.to_sym, Gem::Version.new(target_ver) )
          # print error if the range is not fulfilled
          warn <<~EOT.lightred
            Package #{name} depends on '#{depName}' (#{operator} #{target_ver}), however version '#{installed_ver}' is currently installed :/

            Run `crew update && crew upgrade` and try again?
          EOT
          return false
        end
        return true
      end
    end

    @dependencies.store(depName, [dep_tags, ver_check])
  end

  def self.get_url(architecture)
    if !@build_from_source && @binary_url && @binary_url.key?(architecture)
      return @binary_url[architecture]
    elsif @source_url.respond_to?(:has_key?)
      return @source_url.key?(architecture) ? @source_url[architecture] : nil
    else
      return @source_url
    end
  end

  def self.get_binary_url(architecture)
    return @binary_url.key?(architecture) ? @binary_url[architecture] : nil
  end

  def self.get_source_url(architecture)
    return @source_url.key?(architecture) ? @source_url[architecture] : nil
  end

  def self.get_sha256(architecture)
    if !@build_from_source && @binary_sha256 && @binary_sha256.key?(architecture)
      return @binary_sha256[architecture]
    elsif @source_sha256.respond_to?(:has_key?)
      return @source_sha256.key?(architecture) ? @source_sha256[architecture] : nil
    else
      return @source_sha256
    end
  end

  def self.get_binary_sha256(architecture)
    return @binary_sha256 && @binary_sha256.key?(architecture) ? @binary_sha256[architecture] : ''
  end

  def self.get_extract_dir
    "#{name}.#{Time.now.utc.strftime('%Y%m%d%H%M%S')}.dir"
  end

  def self.is_binary?(architecture)
    if !@build_from_source && @binary_url && @binary_url.key?(architecture)
      return true
    else
      return false
    end
  end

  def self.is_source?(architecture)
    if is_binary?(architecture) || is_fake?
      return false
    else
      return true
    end
  end

  def self.system(*args, **opt_args)
    @crew_env_options_hash = if no_env_options?
                               { 'CREW_DISABLE_ENV_OPTIONS' => '1' }
                             elsif no_lto?
                               CREW_ENV_FNO_LTO_OPTIONS_HASH
                             else
                               CREW_ENV_OPTIONS_HASH
                             end

    # add "-j#" argument to "make" at compile-time, if necessary

    # Order of precedence to assign the number of processors:
    # 1. The value of '-j#' from the package make argument
    # 2. The value of ENV["CREW_NPROC"]
    # 3. The value of `nproc`.strip
    # See lib/const.rb for more details

    # add exception option to opt_args
    opt_args.merge!(exception: true) unless opt_args.key?(:exception)

    # extract env hash
    if args[0].is_a?(Hash)
      env = @crew_env_options_hash.merge(args[0])
      args.delete_at(0) # remove env hash from args array
    else
      env = @crew_env_options_hash
    end

    # after removing the env hash, all remaining args must be command args
    cmd_args = args

    # add -j arg to build commands
    if args.size == 1
      # involve a shell if the command is passed in one single string
      cmd_args = ['bash', '-c', cmd_args[0].sub(/^(make)\b/, "\\1 -j#{CREW_NPROC}")]
    elsif cmd_args[0] == 'make'
      cmd_args.insert(1, "-j#{CREW_NPROC}")
    end

    begin
      Kernel.system(env, *cmd_args, **opt_args)
    rescue StandardError => e
      # print failed line number and error message
      puts "#{e.backtrace[1]}: #{e.message}".orange
      raise InstallError, "`#{env.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')} #{cmd_args.join(' ')}` exited with #{$CHILD_STATUS.exitstatus}".lightred
    end
  end
end
