require 'English'
require 'json'
require_relative 'const'
require_relative 'color'
require_relative 'package_helpers'
require_relative 'require_gem'
require_relative 'selector'

require_gem 'highline'
require_gem 'timeout'

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

class Package
  boolean_property :arch_flags_override, :conflicts_ok, :git_clone_deep, :git_fetchtags, :gem_compile_needed, :gnome, :is_fake, :is_musl, :is_static,
                   :no_binaries_needed, :no_compile_needed, :no_compress, :no_env_options, :no_fhs, :no_filefix, :no_git_submodules, :no_links,
                   :no_lto, :no_mold, :no_patchelf, :no_shrink, :no_source_build, :no_strip, :no_upstream_update, :no_zstd, :patchelf, :prerelease,
                   :print_source_bashrc, :run_tests

  property :description, :homepage, :version, :license, :compatibility,
           :binary_compression, :binary_url, :binary_sha256, :source_url, :source_sha256,
           :git_branch, :git_hashtag, :max_glibc, :min_glibc

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
                     :remove,      # Function to remove package.
                     :postremove   # Function to perform after package removal.

  class << self
    attr_accessor :build_from_source, :cached_build, :in_build, :in_install, :in_upgrade, :missing_binaries, :name
  end

  def self.agree_default_no(message = nil)
    # This defaults to false.
    Timeout.timeout(CREW_AGREE_TIMEOUT_SECONDS) do
      return agree_with_default("#{message} (yes/NO)? ", true, default: 'n')
    end
  rescue Timeout::Error
    return false
  end

  def self.agree_default_yes(message = nil)
    # This defaults to true.
    Timeout.timeout(CREW_AGREE_TIMEOUT_SECONDS) do
      return agree_with_default("#{message} (YES/no)? ", true, default: 'y')
    end
  rescue Timeout::Error
    return true
  end

  def self.agree_to_remove(config_object = nil)
    if File.file? config_object
      identifier = 'file'
    elsif File.directory? config_object
      identifier = 'directory'
    else
      crewlog "Cannot remove #{config_object}."
      return
    end
    if agree_default_no("Would you like to remove the config #{identifier}: #{config_object} ")
      FileUtils.rm_rf config_object
      puts "#{config_object} removed.".lightgreen
    else
      puts "#{config_object} saved.".lightgreen
    end
  end

  def self.load_package(pkg_file)
    # self.load_package: load a package under 'Package' class scope
    #
    pkg_name = File.basename(pkg_file, '.rb')
    class_name = pkg_name.capitalize

    # Read and eval package script under 'Package' class, using the newest file available.
    pkg_file = Dir["{#{CREW_LOCAL_REPO_ROOT}/packages,#{CREW_PACKAGES_PATH}}/#{pkg_name}.rb"].max { |a, b| File.mtime(a) <=> File.mtime(b) }

    # If this package has been removed, it won't be found in either directory, so set it back to what it was before to get a nicer error.
    pkg_file = "#{CREW_PACKAGES_PATH}/#{pkg_name}.rb" if pkg_file.nil?

    class_eval(File.read(pkg_file, encoding: Encoding::UTF_8), pkg_file) unless const_defined?("Package::#{class_name}")
    pkg_obj = const_get(class_name)
    pkg_obj.name = pkg_name

    @crew_current_package = @crew_current_package.nil? ? pkg_obj.name : @crew_current_package

    return pkg_obj
  end

  def self.dependencies
    # We need instance variable in derived class, so do not define it here,
    # base class.  Instead of defining it, we initialize it in a function
    # called from derived classes.
    @dependencies ||= {}
  end

  def self.get_deps_list(pkg_name = name, return_attr: false, hash: false, include_build_deps: 'auto', include_self: false,
                         pkg_tags: [], ver_check: nil, highlight_build_deps: true, exclude_buildessential: false, top_level: true)
    # get_deps_list: get dependencies list of pkg_name (current package by default)
    #
    #                pkg_name: package to check dependencies, current package by default
    #            return_attr: return package attribute (tags and version lambda) also
    #                   hash: return result in nested hash, used by `print_deps_tree` (`bin/crew`)
    #
    #     include_build_deps: if set to true, force all build dependencies to be returned.
    #                         if set to false, all build dependencies will not be returned
    #                         if set to "auto" (default), return build dependencies if pre-built binaries not available
    #
    #           include_self: include #{pkg_name} itself in returned result, only used in recursive calls (see `expanded_deps` below)
    #   highlight_build_deps: include corresponding symbols in return value, you can convert it to actual ascii color codes later
    # exclude_buildessential: do not insert `buildessential` dependency automatically
    #
    #              top_level: if set to true, return satisfied dependencies
    #                         (dependencies that might be a sub-dependency of a dependency that checked before),
    #                         always set to false if this function is called in recursive loop (see `expanded_deps` below)
    #
    @checked_list ||= {} # create @checked_list placeholder if not exist

    # Add current package to @checked_list for preventing extra checks.
    @checked_list.merge!({ pkg_name => pkg_tags })

    pkg_obj = load_package(File.join(CREW_PACKAGES_PATH, "#{pkg_name}.rb"))
    is_source = pkg_obj.source?(ARCH.to_sym) or pkg_obj.build_from_source
    deps = pkg_obj.dependencies

    # Append buildessential to deps if building from source is needed/specified.
    if ((include_build_deps == true) || ((include_build_deps == 'auto') && is_source)) &&
       !pkg_obj.no_compile_needed? &&
       !exclude_buildessential &&
       !@checked_list.keys.include?('buildessential')

      deps = { 'buildessential' => [[:build]] }.merge(deps)
    end

    # Parse dependencies recursively.
    expanded_deps = deps.uniq.map do |dep, (dep_tags, ver_check)|
      # Check build dependencies only if building from source is needed/specified.
      # Do not recursively find :build based build dependencies.
      next unless (include_build_deps == true && @crew_current_package == pkg_obj.name) ||
                  ((include_build_deps == 'auto') && is_source && @crew_current_package == pkg_obj.name) ||
                  !dep_tags.include?(:build)

      # Overwrite tags if parent dependency is a build dependency.
      # (for build dependencies highlighting)
      tags = pkg_tags.include?(:build) ? pkg_tags : dep_tags

      if @checked_list.keys.none?(dep)
        # Check dependency by calling this function recursively.
        next \
          send(
            __method__, dep, pkg_tags: tags, ver_check:, include_self: true, top_level: false,
            hash:, return_attr:, include_build_deps:, highlight_build_deps:, exclude_buildessential:
          )
      elsif hash && top_level
        # Will be dropped here if current dependency is already checked and #{top_level} is set to true.
        #
        # The '+' symbol tell `print_deps_tree` (`bin/crew`) to color this package as a "satisfied dependency".
        # The '*' symbol tell `print_deps_tree` (`bin/crew`) to color this package as a "build dependency".
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
      # The '*' symbol tell `print_deps_tree` (`bin/crew`) to color this package as a "build dependency".
      if highlight_build_deps && pkg_tags.include?(:build)
        return { "*#{pkg_name}*" => expanded_deps }
      else
        return { pkg_name => expanded_deps }
      end
    elsif include_self
      # Return pkg_name itself if this function is called as a recursive loop (see `expanded_deps`).
      if return_attr
        return [expanded_deps, { pkg_name => [pkg_tags, ver_check] }].flatten
      else
        return [expanded_deps, pkg_name].flatten
      end
    else
      # If this function is called outside of this function, return parsed dependencies only.
      return expanded_deps.flatten
    end
  end

  def self.print_deps_tree(args)
    warn 'Walking through dependencies recursively, this may take a while...', ''

    # dep_hash: Hash object returned by @pkg.get_deps_list
    dep_hash = get_deps_list(hash: true, include_build_deps: args['--include-build-deps'] || 'auto', exclude_buildessential: args['--exclude-buildessential'])

    # convert returned hash to json and format it
    json_view = JSON.pretty_generate(dep_hash)

    # convert formatted json string to tree structure
    tree_view = json_view.gsub(/\{\s*/m, '└─────').gsub(/[\[\]{},":]/, '').gsub(/^\s*$\n/, '').gsub(/\s*$/, '')

    # add pipe char to connect endpoints and starting points, improve readability
    # find the horizontal location of all arrow symbols
    index_with_pipe_char = tree_view.lines.map { |line| line.index('└') }.compact.uniq

    # determine whatever a pipe char should be added according to the horizontal location of arrow symbols
    tree_view = tree_view.lines.each_with_index.map do |line, line_i|
      index_with_pipe_char.each do |char_i|
        # check if there have any non-space char (pkg_names) between starting point ([line_i][char_i]) and endpoint vertically ([next_arrow_line_offset][char_i])
        # (used to determine if the starting point and endpoint are in same branch, use pipe char to connect them if true)
        next_arrow_line_offset = tree_view.lines[line_i..].index { |l| l[char_i] == '└' }
        have_line_with_non_empty_char = tree_view.lines[line_i + 1..line_i + next_arrow_line_offset.to_i - 1].any? { |l| l[char_i].nil? or l[char_i] =~ /\S/ }

        line[char_i] = '│' if next_arrow_line_offset && (line[char_i] == ' ') && !have_line_with_non_empty_char
      end
      next line
    end.join

    # replace arrow symbols with a tee symbol on branch intersection
    tree_view = tree_view.lines.each_with_index.map do |line, line_i|
      # orig_arrow_index_connecter: the horizontal location of the arrow symbol used to connect parent branch
      #
      # example:
      # └───┬─chrome
      #     └─────buildessential
      #     ^
      orig_arrow_index_connecter = line.index('└')
      # orig_arrow_index_newbranch: the horizontal location of the "box drawing char" symbol MIGHT be
      #                             required to convert to tee char in order to connect child branch,
      #                             located at 3 chars later of orig_arrow_index_connecter
      #
      # example:
      #     v
      # └─────chrome
      #     └─────buildessential
      #
      # which might need to be convert to:
      # └───┬─chrome
      #     └─────buildessential
      orig_arrow_index_newbranch = orig_arrow_index_connecter + 4

      # if the char under the processing arrow symbol (orig_arrow_index_connecter) is also arrow or pipe, change the processing char to tee symbol
      line[orig_arrow_index_connecter] = '├' if orig_arrow_index_connecter && tree_view.lines[line_i + 1].to_s[orig_arrow_index_connecter] =~ /[└│]/
      # if the char under the processing arrow symbol (orig_arrow_index_newbranch) is also arrow or pipe, change the processing char to tee symbol
      line[orig_arrow_index_newbranch] = '┬' if orig_arrow_index_newbranch && tree_view.lines[line_i + 1].to_s[orig_arrow_index_newbranch] =~ /[└├]/
      next line # return modified line
    end.join

    if String.use_color
      puts <<~EOT, ''
        \e[45m \e[0m: satisfied dependency
        \e[46m \e[0m: build dependency
        \e[47m \e[0m: runtime dependency
      EOT
      # (the first string in each #{} is used for commenting only, will not be included in output)

      # replace special symbols returned by @pkg.get_deps_list to actual color code
      tree_view.gsub!(/\*(.+)\*/, '\1'.lightcyan)
      tree_view.gsub!(/\+(.+)\+/, "\e[45m\\1\e[0m")
    end

    puts tree_view
  end

  def self.depends_on(dependency, ver_range = nil)
    @dependencies ||= {}
    ver_check = nil
    dep_tags  = []

    # Add element in "[ name, [ tag1, tag2, ... ] ]" format.
    if dependency.is_a?(Hash)
      # Parse "depends_on name => <tags: Symbol|Array>".
      dep_name, tags = dependency.first

      # Convert `tags` to array in case `tags` is a symbol.
      dep_tags += [tags].flatten
    else
      # Parse "depends_on name".
      dep_name = dependency
    end

    # Process dependency version range if specified.
    # example:
    #   depends_on name, '>= 1.0'
    #
    # Operators can be: '>=', '==', '<=', '<', or '>'
    if ver_range
      operator, target_ver = ver_range.split(' ', 2)

      # lambda for comparing the given range with installed version
      ver_check = lambda do |installed_ver|
        unless Gem::Version.new(installed_ver).send(operator.to_sym, Gem::Version.new(target_ver))
          # Print error if the range is not fulfilled.
          warn <<~EOT.lightred
            Package #{name} depends on '#{dep_name}' (#{operator} #{target_ver}), however version '#{installed_ver}' is currently installed :/

            Run `crew update && crew upgrade` and try again?
          EOT
          return false
        end
        return true
      end
    end

    @dependencies.store(dep_name, [dep_tags, ver_check])
  end

  def self.binary?(architecture) = !@build_from_source && @binary_sha256&.key?(architecture)
  def self.source?(architecture) = missing_binaries ? true : !(binary?(architecture) || is_fake?)

  def self.system(*args, **opt_args)
    crew_env_options_hash = if no_env_options?
                              { 'CREW_DISABLE_ENV_OPTIONS' => '1' }
                            elsif no_lto?
                              CREW_ENV_FNO_LTO_OPTIONS_HASH
                            else
                              CREW_ENV_OPTIONS_HASH
                            end
    # Replace CREW_ARCH_FLAGS if @arch_flags_override is true.
    crew_env_options_hash.transform_values! { |v| v.gsub(CREW_ARCH_FLAGS, CREW_ARCH_FLAGS_OVERRIDE) } if arch_flags_override

    # Add exception option to opt_args.
    opt_args.merge!(exception: true) unless opt_args.key?(:exception)

    # Extract env hash.
    if args[0].is_a?(Hash)
      env = crew_env_options_hash.merge(args[0])
      args.delete_at(0) # Remove env hash from args array.
    else
      env = crew_env_options_hash
    end

    env['CREW_PRELOAD_ENABLE_COMPILE_HACKS'] = opt_args.delete(:no_preload_hacks) ? '0' : '1'
    env['CREW_PRELOAD_NO_MOLD']              = @no_mold ? '1' : '0'
    env['LD_PRELOAD']                        = File.join(CREW_LIB_PREFIX, 'crew-preload.so') if File.exist?("#{CREW_LIB_PREFIX}/crew-preload.so")

    # After removing the env hash, all remaining args must be command args.

    begin
      Kernel.system(env, *args, **opt_args)
    rescue RuntimeError => e
      # Print failed line number and error message.
      puts "#{e.backtrace[1]}: #{e.message}".orange
      raise InstallError, "`#{env.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')} #{cmd_args.join(' ')}` exited with #{$CHILD_STATUS.exitstatus}".lightred
    end
  end
end
