require 'package'
require 'fileutils'

class Wine < Package
  description 'Wine (originally an acronym for "Wine Is Not an Emulator") is a compatibility layer capable of running Windows applications on several POSIX-compliant operating systems, such as Linux, macOS, & BSD.'
  homepage 'https://www.winehq.org/'
  version '2.10-1'
  source_url 'https://dl.winehq.org/wine/source/2.x/wine-2.10.tar.xz'
  source_sha256 '488df7ffd2e81da455bf428fc9eb784bb4273a890334500895665711bd52f179'

  binary_url ({
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/wine-2.10-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/wine-2.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: 'e63305875d9500bf0e8e1f1f78eb97543a76b5b4a275a02871c81b518094e64d',
     x86_64: 'a1aa4875eaedd55e62e5d8b0d884e4b41cb3460a36e7448749ff1da55a6f6b6d',
  })

  depends_on 'bison'
  depends_on 'flex'
  depends_on 'freetype'

  def self.build
    case ARCH
    when "i686", "armv7l", "aarch64"
      system "./configure --without-x"
    when "x86_64"
      system "./configure --without-x --enable-win64"
    else
      abort "Error getting your device configuration."
    end
    system "make"
  end

  def self.install
    case ARCH
    when "x86_64"
      system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
      FileUtils.cd("#{CREW_DEST_DIR}/usr/local/bin") do
        system "ln -s wine64 wine"
      end
    end
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
