require 'package'

class Libmypaint < Package
  description 'Libmypaint is MyPaint\'s brushstroke rendering code, in a form that can be used by other programs.'
  homepage 'http://mypaint.org/'
  version '1.3.0'
  compatibility 'all'
  source_url 'https://github.com/mypaint/libmypaint/releases/download/v1.3.0/libmypaint-1.3.0.tar.xz'
  source_sha256 '6a07d9d57fea60f68d218a953ce91b168975a003db24de6ac01ad69dcc94a671'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libmypaint-1.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libmypaint-1.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libmypaint-1.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libmypaint-1.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '29ba70ec439d8b183f2986bb9e876da62efa9f7b82341965b94e0bcec684708a',
     armv7l: '29ba70ec439d8b183f2986bb9e876da62efa9f7b82341965b94e0bcec684708a',
       i686: 'aed779ae7fe6f2ed39d5001d11a805fb9bcd7c555881cec7d66a6c3b3a350474',
     x86_64: '40f0a303a68f4ff29f5754440a41e24ea48de87a410a2aedb9f84925094fe24e',
  })

  depends_on 'gegl'
  depends_on 'jsonc'

  def self.build
    system "sed -i 's,gegl-0.3,gegl-0.4,' gegl/Makefile.am"
    system "sed -i 's,Gegl-0.3,Gegl-0.4,' gegl/Makefile.am"
    system "sed -i 's,gegl-0.3,gegl-0.4,' gegl/Makefile.in"
    system "sed -i 's,Gegl-0.3,Gegl-0.4,' gegl/Makefile.in"
    system "GEGL_LIBS=\"#{CREW_LIB_PREFIX}/gegl-0.4\" \
           GEGL_CFLAGS=\"-I#{CREW_PREFIX}/include/gegl-0.4 \
           -I#{CREW_PREFIX}/include/babl-0.1 \
           -I#{CREW_PREFIX}/include/glib-2.0\" \
           ./configure \
           --prefix=#{CREW_PREFIX} \
           --libdir=#{CREW_LIB_PREFIX} \
           --disable-maintainer-mode \
           --enable-openmp \
           --enable-gegl"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
