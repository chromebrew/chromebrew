require 'package'
require 'fileutils'

class Wine < Package
  description 'Wine (originally an acronym for "Wine Is Not an Emulator") is a compatibility layer capable of running Windows applications on several POSIX-compliant operating systems, such as Linux, macOS, & BSD.'
  homepage 'https://www.winehq.org/'
  version '2.10-1'
  source_url 'https://dl.winehq.org/wine/source/2.x/wine-2.10.tar.xz'
  source_sha256 '488df7ffd2e81da455bf428fc9eb784bb4273a890334500895665711bd52f179'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/wine-2.10-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/wine-2.10-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/wine-2.10-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/wine-2.10-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'de6c0bdaf7e2b913a4170588eb1474b34ef48cca4de848aabd8e1b875c6323b4',
     armv7l: 'de6c0bdaf7e2b913a4170588eb1474b34ef48cca4de848aabd8e1b875c6323b4',
       i686: 'f741ba56e1d18d26813feab82a2997017ae3325e19cf449c32a61589717178dd',
     x86_64: '217be92db577ede5038f0bceb1800453bad4e89f2af8f26cdab6afe99384ae2a',
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
