require 'package'

class Libcaca < Package
  description 'libcaca is a graphics library that outputs text instead of pixels, so that it can work on older video cards or text terminals.'
  homepage 'http://caca.zoy.org/wiki/libcaca'
  version '0.99.beta19'
  source_url 'http://caca.zoy.org/files/libcaca/libcaca-0.99.beta19.tar.gz'
  source_sha256 '128b467c4ed03264c187405172a4e83049342cc8cc2f655f53a2d0ee9d3772f4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcaca-0.99.beta19-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcaca-0.99.beta19-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcaca-0.99.beta19-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcaca-0.99.beta19-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '43d441fc33c3193911555bcc802944e18c00c7a94bb5d2d55daf993bba2343fc',
     armv7l: '43d441fc33c3193911555bcc802944e18c00c7a94bb5d2d55daf993bba2343fc',
       i686: '8a2aee2e085788984c0cd99ec4142ad330e593458a86ad9d976b6b6c46c143fa',
     x86_64: '7683ba9192da59df87cf73573221d40de361ea2698fafdfb22713d1ccc11ecd9',
  })

  depends_on 'ncurses'
  depends_on 'slang'

  def self.build
    system "sed -i 's,caca.h,../caca/caca.h,' java/org_zoy_caca_Attribute.c"
    system "sed -i 's,caca_types.h,../caca/caca_types.h,' caca/caca.h"
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --enable-ncurses \
            --enable-slang \
            --disable-x11 \
            --without-x"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
