require 'package_helpers'

class Package
  property :description, :homepage, :version, :license, :compatibility,
           :binary_url, :binary_sha256, :source_url, :source_sha256,
           :git_branch, :git_hashtag

  boolean_property = %i[git_fetchtags is_fake is_musl is_static no_patchelf patchelf]

  create_placeholder :preflight,   # Function for checks to see if install should occur.
                     :patch,       # Function to perform patch operations prior to build from source.
                     :prebuild,    # Function to perform pre-build operations prior to build from source.
                     :build,       # Function to perform build from source.
                     :postbuild,   # Function to perform post-build for both source build and binary distribution.
                     :check,       # Function to perform check from source build. (executes only during `crew build`)
                     :preinstall,  # Function to perform pre-install operations prior to install.
                     :install,     # Function to perform install from source build.
                     :postinstall, # Function to perform post-install for both source build and binary distribution.
                     :remove       # Function to perform after package removal.

  class << self
    attr_accessor :name, :is_dep, :in_build, :build_from_source, :in_upgrade
  end

  def self.dependencies
    # We need instance variable in derived class, so not define it here,
    # base class.  Instead of define it, we initialize it in a function
    # called from derived classees.
    @dependencies ||= Hash.new
    @dependencies
  end

  boolean_property.each do |prop|
    self.class.__send__(:attr_reader, "#{prop}")
    class_eval <<~EOT, __FILE__, __LINE__ + 1
      def self.#{prop} (#{prop} = nil)
        @#{prop} = true if #{prop}
        !!@#{prop}
      end
    EOT
    instance_eval <<~EOY, __FILE__, __LINE__ + 1
      def self.#{prop}
        @#{prop} = true
      end
    EOY
    # Adds the symbol? method
    define_singleton_method("#{prop}?") do
      @prop = instance_variable_get("@" + prop.to_s)
      !!@prop
    end
  end

  def self.depends_on (dependency = nil)
    @dependencies ||= Hash.new
    if dependency
      # add element in "[ name, [ tag1, tag2, ... ] ]" format
      if dependency.is_a?(Hash)
        if dependency.first[1].is_a?(Array)
          # parse "depends_on name => [ tag1, tag2 ]"
          @dependencies.store(dependency.first[0], dependency.first[1])
        else
          # parse "depends_on name => tag"
          @dependencies.store(dependency.first[0], [dependency.first[1]])
        end
      else
        # parse "depends_on name"
        @dependencies.store(dependency, [])
      end
    end
    @dependencies
  end

  def self.get_url (architecture)
    if !@build_from_source and @binary_url and @binary_url.has_key?(architecture)
      return @binary_url[architecture]
    else
      if @source_url.respond_to?(:has_key?)
        return @source_url.has_key?(architecture) ? @source_url[architecture] : nil
      else
        return @source_url
      end
    end
  end

  def self.get_binary_url (architecture)
    return @binary_url.has_key?(architecture) ? @binary_url[architecture] : nil
  end

  def self.get_source_url (architecture)
    return @source_url.has_key?(architecture) ? @source_url[architecture] : nil
  end

  def self.get_sha256 (architecture)
    if !@build_from_source and @binary_sha256 and @binary_sha256.has_key?(architecture)
      return @binary_sha256[architecture]
    else
      if @source_sha256.respond_to?(:has_key?)
        return @source_sha256.has_key?(architecture) ? @source_sha256[architecture] : nil
      else
        return @source_sha256
      end
    end
  end

  def self.get_extract_dir
    name + '.' + Time.now.utc.strftime("%Y%m%d%H%M%S") + '.dir'
  end

  def self.is_binary? (architecture)
    if !@build_from_source and @binary_url and @binary_url.has_key?(architecture)
      return true
    else
      return false
    end
  end

  def self.is_source? (architecture)
    if is_binary?(architecture) or is_fake?
      return false
    else
      return true
    end
  end

  def self.system(*args, **opt_args)
    # add "-j#" argument to "make" at compile-time, if necessary

    # Order of precedence to assign the number of processors:
    # 1. The value of '-j#' from the package make argument
    # 2. The value of ENV["CREW_NPROC"]
    # 3. The value of `nproc`.strip
    # See lib/const.rb for more details

    # add exception option to opt_args
    opt_args.merge!(exception: true)

    # extract env hash
    if args[0].is_a?(Hash)
      env = CREW_ENV_OPTIONS_HASH.merge(args[0])
      args.delete_at(0) # remove env hash from args array
    else
      env = CREW_ENV_OPTIONS_HASH
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
    rescue => e
      # print failed line number and error message
      puts "#{e.backtrace[1]}: #{e.message}".orange
      raise InstallError, "`#{env.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')} #{cmd_args.join(' ')}` exited with #{$?.exitstatus}".lightred
    end
  end
end
