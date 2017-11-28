require 'package'

class Apriconv < Package
  description 'a portable implementation of the iconv() library'
  homepage 'http://apr.apache.org/'
  version '1.2.2'
  source_url 'https://apache.claz.org/apr/apr-iconv-1.2.2.tar.bz2'
  source_sha256 '7d454e0fe32f2385f671000e3b755839d16aabd7291e3947c973c90377c35313'

  binary_url ({
  })
  binary_sha256 ({
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
