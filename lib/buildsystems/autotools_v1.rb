require 'package'

class Autotools_v1 < Package
  @_buildsystems_autotools_version = '1.0.0'

  def self.configure_options (options = nil)
    if options
      @configure_options = options
    end
    @configure_options
  end

  def self.check? (bool)
    if bool == true
      @check = true
    else
      @check = false
    end
    @check
  end

  def self.build
    # Run autoreconf if necessary
    unless File.exist? './configure'
      if File.exist? './autogen.sh'
        system 'NOCONFIGURE=1 ./autogen.sh'
      elsif File.exist? './bootstrap'
        system 'NOCONFIGURE=1 ./bootstrap'
      else
        system 'autoreconf -fiv'
      end
    end
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              #{@conifugre_options}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  if @check == true
    def self.check
      system 'make', 'check'
    end
  end
end
