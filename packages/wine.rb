require 'package'
require 'fileutils'

class Wine < Package
  description 'Wine (originally an acronym for "Wine Is Not an Emulator") is a compatibility layer capable of running Windows applications on several POSIX-compliant operating systems, such as Linux, macOS, & BSD.'
  homepage 'https://www.winehq.org/'
  compatibility 'all'
  version '3.13'
  source_url 'https://dl.winehq.org/wine/source/3.x/wine-3.13.tar.xz'
  source_sha256 '0785d74852232c1f6e07ac081875e92219a4428ddcc8931632fcf1924941bbd4'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'bison'
  depends_on 'sommelier'
  depends_on 'flex'
  depends_on 'freetype'

  def self.build
    case ARCH
    when "i686", "armv7l", "aarch64"
      system "./configure"
    when "x86_64"
      system "./configure --enable-win64"
    else
      abort 'Error getting your device configuration.'.lightred
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
