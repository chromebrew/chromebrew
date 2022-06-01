require 'package'

class Autotools_v1 < Package
  @_buildsystems_autotools_version = '1.0.0'

  def self.configure_options (options = '')
    if options
      @configure_options = options
    end
    return @configure_options
  end

  def self.check? (bool = true)
    @check = bool
    return @check
  end

  def self.build
    # Run autoreconf if necessary
    unless File.executable? './configure'
      if File.executable? './autogen.sh'
        system 'NOCONFIGURE=1 ./autogen.sh'
      elsif File.executable? './bootstrap'
        system 'NOCONFIGURE=1 ./bootstrap'
      else
        system 'autoreconf -fiv'
      end
    end
    system "./configure #{CREW_OPTIONS} \
              #{@configure_options}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  if @check
    def self.check
      system 'make', 'check'
    end
  end
end
