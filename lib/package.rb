require 'package_helpers'

class Package
  property :version, :binary_url, :binary_sha1, :source_url, :source_sha1, :is_fake
  
  class << self
    attr_reader :dependencies, :rdependencies, :is_fake
    attr_accessor :name
  end
  def self.depends_on (dependency = nil)
    @dependencies = [] unless @dependencies
    if dependency
      @dependencies << dependency
    end
    @dependencies
  end

  def self.rdepends_on (dependency = nil)
    @rdependencies = [] unless @rdependencies
    if dependency
      @rdependencies << dependency
    end
    @rdependencies
  end
  
  def self.is_fake
    @is_fake = true
  end
  
  def self.is_fake?
    @is_fake
  end

  def self.build
    
  end

  def self.system(*args)
    # add "-j#{CREW_NPROC}" argument to "make"
    if args[0] == "make"
      # modify ["make", "args", ...] into ["make", "-j#{CREW_NPROC}", "args", ...]
      args.insert(1, "-j#{CREW_NPROC}")
    elsif args.length == 1
      # modify ["make args..."] into ["make -j#{CREW_NPROC} args..."]
      args[0].gsub!(/^make /, "make -j#{CREW_NPROC} ")
    end
    Kernel.system(*args)
    exitstatus = $?.exitstatus
    raise InstallError.new("`#{args.join(" ")}` exited with #{exitstatus}") unless exitstatus == 0
  end
end
