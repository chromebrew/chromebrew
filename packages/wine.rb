require 'package'
require 'fileutils'

class Wine < Package
  description 'Wine (originally an acronym for "Wine Is Not an Emulator") is a compatibility layer capable of running Windows applications on several POSIX-compliant operating systems, such as Linux, macOS, & BSD.'
  homepage 'https://www.winehq.org/'
  compatibility 'all'
  version '5.0.2-stable'
  source_url 'https://dl.winehq.org/wine/source/5.0/wine-5.0.2.tar.xz'
  source_sha256 'c2c284f470874b35228327c3972bc29c3a9d8d98abd71dbf81c288b8642becbc'

  depends_on 'bison'
  depends_on 'sommelier'
  depends_on 'flex'
  depends_on 'freetype'

  def self.build
    case ARCH
    when "i686", "armv7l", "aarch64"
      system "./configure"
    when "x86_64"
      system "./configure", 
             "--enable-win64",
             "--without-freetype"
    else
      abort 'Error getting your device configuration. :/'.lightred
    end
    system 'make'
  end

  def self.install
    case ARCH
    when "x86_64"
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
      FileUtils.cd("#{CREW_DEST_PREFIX}/bin") do
        system "ln -s wine64 wine"
      end
    end
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
