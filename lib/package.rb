require 'package_helpers'

class Package
  property :description, :homepage, :version, :compatibility, :binary_url, :binary_sha1, :binary_sha256, :source_url, :source_sha1, :source_sha256, :is_fake

  class << self
    attr_reader :is_fake
    attr_accessor :name, :in_build, :build_from_source
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

    # Order of precendence to assign the number of processors:
    # 1. The value of '-j#' from the package make argument
    # 2. The value of ENV["CREW_NPROC"]
    # 3. The value of `nproc`.strip
    # See lib/const.rb for more details

    if @in_build == true
      nproc = ''
      nproc_opt =  ''
      args.each do |arg|
        params = arg.split(/\W+/)
        params.each do |param|
          if param.match(/j(\d)+/)
            nproc_opt = param
            break
          end
        end
      end
      nproc = "#{CREW_NPROC}" if nproc_opt == ''
      if args[0] == "make"
        # modify ["make", "args", ...] into ["make", "-j#{nproc}", "args", ...]
        args.insert(1, "-j#{nproc}") if nproc != ''
        if @opt_verbose then
          args.insert(1, "V=1")
        else
          args.insert(1, "V=0")
        end
      elsif args.length == 1
        # modify ["make args..."] into ["make -j#{nproc} args..."]
        args[0].gsub!(/^make /, "make -j#{nproc} ") if nproc != ''
        if @opt_verbose then
          args[0].gsub!(/^make /, "make V=1 ")
        else
          args[0].gsub!(/^make /, "make V=0 ")
        end
      end
    end
    Kernel.system(*args)
    exitstatus = $?.exitstatus
    raise InstallError.new("`#{args.join(" ")}` exited with #{exitstatus}") unless exitstatus == 0
  end
  def self.make_install (destdir = CREW_DEST_PREFIX, opt = '')
    @warning = 'libtool: warning: remember to run '
        @out = "#{CREW_BREW_DIR}/libtool.txt"

    system "make DESTDIR=#{destdir} install #{opt} 2>&1 |\
            tee #{@out} |\
            grep -v \"#{@warning}\""

    system "grep -oP \"(?<=#{@warning}\').*?(?=\')\" #{@out} | bash"
  end
end
