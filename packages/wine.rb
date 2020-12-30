require 'package'
require 'fileutils'

class Wine < Package
  description 'Wine (originally an acronym for "Wine Is Not an Emulator") is a compatibility layer capable of running Windows applications on several POSIX-compliant operating systems, such as Linux, macOS, & BSD.'
  homepage 'https://www.winehq.org/'
  compatibility 'aarch64,armv7l,x86_64'
  version '5.22'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://dl.winehq.org/wine/source/5.x/wine-5.22.tar.xz'
    source_sha256 '09bd06c87c8c974e6ad34507cec875d7217eb56fc09df838d5453e0ebbce4d21'
    depends_on 'freetype'
    depends_on 'glib'
    depends_on 'libgphoto'
    depends_on 'libxext'
    depends_on 'eudev'
    depends_on 'gstreamer'
    depends_on 'lcms'
    depends_on 'openldap'
    depends_on 'libpcap'
    depends_on 'apulse'
    depends_on 'mpg123'
    depends_on 'ffmpeg'
    depends_on 'sommelier'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wine-5.22-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wine-5.22-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wine-5.22-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e9f8a89103ea4a6f17b75f044b0ccff30eb273d48bc211eee145b49b7a917ef7',
     armv7l: 'e9f8a89103ea4a6f17b75f044b0ccff30eb273d48bc211eee145b49b7a917ef7',
     x86_64: '08df0a325ffc77756152d8bffd36c45e910c1ade4e6332b51f3dcb0fa042efee',
  })

  def self.build
    case ARCH
    when 'x86_64'
      system "./configure #{CREW_OPTIONS} --enable-win64 --disable-maintainer-mode --with-x"
    else
      system "./configure #{CREW_OPTIONS} --disable-maintainer-mode --with-x"
    end
    system 'make'
  end

  def self.install
    case ARCH
    when 'x86_64'
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
      Dir.chdir "#{CREW_DEST_PREFIX}/bin" do
        FileUtils.ln_s 'wine64', 'wine'
      end
    end
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.postinstall
    puts
    puts "Type 'wine explorer' to get started using the file explorer.".lightblue
    puts
  end

  def self.remove
    if Dir.exists? "#{HOME}/.wine"
      puts
      print "Would you like to remove #{HOME}/.wine? [y/N] "
      response = STDIN.getc
      case response
      when "y", "Y"
        FileUtils.rm_rf "#{HOME}/.wine"
        puts "#{HOME}/.wine removed.".lightred
      else
        puts "#{HOME}/.wine saved.".lightgreen
      end
      puts
    end
  end
end
