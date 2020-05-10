require 'package'

class Apriconv < Package
  description 'a portable implementation of the iconv() library'
  homepage 'http://apr.apache.org/'
  version '1.2.2'
  compatibility 'all'
  source_url 'https://apache.claz.org/apr/apr-iconv-1.2.2.tar.bz2'
  source_sha256 '7d454e0fe32f2385f671000e3b755839d16aabd7291e3947c973c90377c35313'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/apriconv-1.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/apriconv-1.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/apriconv-1.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/apriconv-1.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6ec314d1d6143a855e59d5a3b76db311e3ba60b980b98be3d639c39e74949fed',
     armv7l: '6ec314d1d6143a855e59d5a3b76db311e3ba60b980b98be3d639c39e74949fed',
       i686: 'ef8a4e543d11b010edae76ec4ea4d06be68b41a3d4e31bc8764969f2d216d8e5',
     x86_64: 'd3abcd64112eb46aef6bb090409471c9fbaf675cd258aff0220d696fed9b6771',
  })

  depends_on 'apr'
  depends_on 'libtool'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --with-apr=#{CREW_PREFIX}"
    system "sed -i 's,/usr/local/lib,#{CREW_LIB_PREFIX},g' Makefile"
    system "sed -i 's,/usr/local/lib,#{CREW_LIB_PREFIX},g' ccs/Makefile"
    system "sed -i 's,/usr/local/lib,#{CREW_LIB_PREFIX},g' ces/Makefile"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "libtool --mode=finish #{CREW_DEST_LIB_PREFIX}/iconv"
  end
end
