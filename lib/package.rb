require 'package_helpers'

class Package
  property :description, :homepage, :version, :binary_url, :binary_sha1, :source_url, :source_sha1, :is_fake

  class << self
    attr_reader :is_fake
    attr_accessor :name, :in_build, :build_from_source
    attr_accessor :in_upgrade
  end

  @@debug_symbol = ENV['CREW_DEBUG_SYMBOL'] || false

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
    if !@build_from_source && @binary_url && @binary_url.has_key?(architecture)
      return @binary_url[architecture]
    else
      return @source_url
    end
  end

  def self.is_binary? (architecture)
    if !@build_from_source && @binary_url && @binary_url.has_key?(architecture)
      return true
    else
      return false
    end
  end

  def self.is_source? (architecture)
    if is_binary?(architecture) || is_fake?
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

  def self.build

  end

  def self.check

  end

  def self.system(*args)
    # add "-j#{CREW_NPROC}" argument to "make" at only compile-time
    if @in_build == true
      if args[0] == "make"
        # modify ["make", "args", ...] into ["make", "-j#{CREW_NPROC}", "args", ...]
        args.insert(1, "-j#{CREW_NPROC}")
      elsif args.length == 1
        # modify ["make args..."] into ["make -j#{CREW_NPROC} args..."]
        args[0].gsub!(/^make /, "make -j#{CREW_NPROC} ")
      end
    end
    Kernel.system(*args)
    exitstatus = $?.exitstatus
    raise InstallError.new("`#{args.join(" ")}` exited with #{exitstatus}") unless exitstatus == 0
  end
end
