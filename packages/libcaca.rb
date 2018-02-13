require 'package'

class Libcaca < Package
  description 'libcaca is a graphics library that outputs text instead of pixels, so that it can work on older video cards or text terminals.'
  homepage 'http://caca.zoy.org/wiki/libcaca'
  version '0.99.beta19'
  source_url 'http://caca.zoy.org/files/libcaca/libcaca-0.99.beta19.tar.gz'
  source_sha256 '128b467c4ed03264c187405172a4e83049342cc8cc2f655f53a2d0ee9d3772f4'

  binary_url ({
  })
  binary_sha256 ({
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
