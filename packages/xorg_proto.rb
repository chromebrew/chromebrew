require 'package'

class Xorg_proto < Package
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/'
  version '2018.4'
  source_url 'https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2018.4.tar.bz2'
  source_sha256 'fee885e0512899ea5280c593fdb2735beb1693ad170c22ebcc844470eec415a0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2018.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2018.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2018.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_proto-2018.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '92f1d6ea6ef2c905f2ae1749c57e0d6b962145f9936ce726b64624af4e835549',
     armv7l: '92f1d6ea6ef2c905f2ae1749c57e0d6b962145f9936ce726b64624af4e835549',
       i686: 'f9b2d6bd821fbac154f818ebe43eb5c5b07b4bfacb8ab66a141c7e7fcd6feaef',
     x86_64: '1285c5962d32f9ca776261cd0a7ccf78b8fda8878d11032673932892c98e5b88',
  })

  def self.build
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--datadir=#{CREW_LIB_PREFIX}",   # install *.pc in #{CREW_LIB_PREFIX}/pkgconfig
           "--enable-strict-compilation",
           "--enable-specs"
    system "make"
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
  

end
