require 'package_helpers'

class Package
  property :description, :homepage, :version, :license, :compatibility,
           :binary_url, :binary_sha256, :source_url, :source_sha256,
           :git_branch, :git_hashtag, :is_fake

  class << self
    attr_reader :is_fake
    attr_accessor :name, :is_dep, :in_build, :build_from_source
    attr_accessor :in_upgrade
  end

  def self.dependencies
    # We need instance variable in derived class, so not define it here,
    # base class.  Instead of define it, we initialize it in a function
    # called from derived classees.
    @dependencies = Hash.new unless @dependencies
    @dependencies
  end

  def self.depends_on (dependency = nil)
    @dependencies = Hash.new unless @dependencies
    if dependency
      # add element in "[ name, [ tag1, tag2, ... ] ]" format
      if dependency.is_a?(Hash)
        if dependency.first[1].is_a?(Array)
          # parse "depends_on name => [ tag1, tag2 ]"
          @dependencies.store(dependency.first[0], dependency.first[1])
        else
          # parse "depends_on name => tag"
          @dependencies.store(dependency.first[0], [ dependency.first[1] ])
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

  def self.is_fake
    @is_fake = true
  end

  def self.is_fake?
    @is_fake
  end

  # Function for checks to see if install should occur.
  def self.preflight

  end

  # Function to perform patch operations prior to build from source.
  def self.patch

  end

  # Function to perform pre-build operations prior to build from source.
  def self.prebuild

  end

  # Function to perform build from source.
  def self.build

  end

  # Function to perform check from source build.
  # This executes only during `crew build`.
  def self.check

  end

  # Function to perform pre-install operations prior to install.
  def self.preinstall

  end

  # Function to perform install from source build.
  def self.install

  end

  # Function to perform post-install for both source build and binary distribution.
  def self.postinstall

  end

  # Function to perform after package removal.
  def self.remove

  end

  def self.system(*args)
    # add "-j#" argument to "make" at compile-time, if necessary

    # Order of precedence to assign the number of processors:
    # 1. The value of '-j#' from the package make argument
    # 2. The value of ENV["CREW_NPROC"]
    # 3. The value of `nproc`.strip
    # See lib/const.rb for more details

    # extract command arguments
    cmd_args = args.select {|arg| arg.is_a?(String) } .join(' ')

    # extract env variables (if provided)
    env_options = if args[0].is_a?(Hash)
      # merge CREW_ENV_OPTIONS and given env variables
      CREW_ENV_OPTIONS.scan(/\b(.+?)=(.+)\b/).to_h.merge(args[0])
    else
      # return CREW_ENV_OPTIONS in hash
      CREW_ENV_OPTIONS.scan(/\b(.+?)=(.+)\b/).to_h
    end
  
    # extract Kernel.system options (if provided)
    system_options = if args[-1].is_a?(Hash)
      { exception: true }.merge(args[-1])
    else
      { exception: true }
    end

    # add -j arg to build commands
    cmd_args.sub(/\b(?<=make)(?=\b)/, " -j#{CREW_NPROC}") unless cmd_args =~ /-j\s*\d+/

    begin
      # use bash instead of /bin/sh
      Kernel.system env_options,
                    'bash', '-e', '-c',
                    cmd_args,       # ensure the command is passed first
                    system_options  # pass Kernel.system options (all args after command) then
    rescue => e
      exitstatus = $?.exitstatus
      # print failed line number and error message
      puts "#{e.backtrace[1]}: #{e.message}".orange
      raise InstallError.new("`#{cmd_args.join(' ')}` exited with #{exitstatus}")
    end
  end
end
