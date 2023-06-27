require 'package'

class Autotools < Package

  def self.configure_options(options = '')
    return (@configure_options = options if options)
  end

  def self.check?(bool = true)
    return (@check = bool)
  end

  def self.build
    puts "Additional configure_options being used: #{if @configure_options.nil? or @configure_options.empty? ; '<no configure_options>' ; else ; @configure_options ; end}".orange
    # Run autoreconf if necessary
    unless File.executable? './configure'
      if File.executable? './autogen.sh'
        system 'NOCONFIGURE=1 ./autogen.sh --no-configure || NOCONFIGURE=1 ./autogen.sh'
      elsif File.executable? './bootstrap'
        system 'NOCONFIGURE=1 ./bootstrap --no-configure || NOCONFIGURE=1 ./bootstrap'
      else
        system 'autoreconf -fiv'
      end
    end
    system "./configure #{CREW_OPTIONS} #{@configure_options}"
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
