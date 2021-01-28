require 'package'

class Libunwind < Package
  description 'libunwind is a portable and efficient C programming interface (API) to determine the call-chain of a program.'
  homepage 'https://www.nongnu.org/libunwind/'
  version '1.5.0-1'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/libunwind/libunwind-1.5.0.tar.gz'
  source_sha256 '90337653d92d4a13de590781371c604f9031cdb50520366aa1e3a91e1efb1017'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.5.0-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.5.0-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.5.0-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libunwind-1.5.0-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'c1b315c17464f67a1e719a615da0154c661eaf1e6e1584f8a68870a2de8721e8',
      armv7l: 'c1b315c17464f67a1e719a615da0154c661eaf1e6e1584f8a68870a2de8721e8',
        i686: 'd697d0a6c015dc8c01593669679c367ca0c9f412e140adb2d4ced0af9fb42fb2',
      x86_64: 'a759499690b70258e91d8ac7cd32047a3cf3308364b04f062e8fc60a33782ec6',
  })

  def self.build
    system "env CFLAGS='-pipe -flto=auto' CXXFLAGS='-pipe -flto=auto' LDFLAGS='-flto=auto' \
    ./configure #{CREW_OPTIONS} --enable-ptrace"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
