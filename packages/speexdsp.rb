require 'package'

class Speexdsp < Package
  description 'Speex is an Open Source/Free Software patent-free audio compression format designed for speech.'
  homepage 'https://speex.org/'
  version '1.2rc3'
  compatibility 'all'
  source_url 'http://downloads.xiph.org/releases/speex/speexdsp-1.2rc3.tar.gz'
  source_sha256 '4ae688600039f5d224bdf2e222d2fbde65608447e4c2f681585e4dca6df692f1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/speexdsp-1.2rc3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/speexdsp-1.2rc3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/speexdsp-1.2rc3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/speexdsp-1.2rc3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0aa0fe549eb030ed9e134a39526751817d9e117509ce3dcbae1c7e3b6dfe8602',
     armv7l: '0aa0fe549eb030ed9e134a39526751817d9e117509ce3dcbae1c7e3b6dfe8602',
       i686: '5c3d9bd633a11a8da1e8408d6db745f620d759ea2e4f8239a9ab5b34a9fe6b6a',
     x86_64: '8a83dac7387460d2dbeb3602712cd7b1d0999ba5b6e3f86449e8f215b4a83682',
  })

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --disable-dependency-tracking \
            --disable-maintainer-mode \
            --disable-examples"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
