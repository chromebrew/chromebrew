require 'package'

class Xorg_proto < Package
  description 'The xorgproto package provides the header files required to build the X Window system, and to allow other applications to build against the installed X Window system.'
  homepage 'https://www.x.org/'
  version '2019.2'
  source_url 'https://xorg.freedesktop.org/archive/individual/proto/xorgproto-2019.2.tar.bz2'
  source_sha256 '46ecd0156c561d41e8aa87ce79340910cdf38373b759e737fcbba5df508e7b8e'

  binary_url ({
  })
  binary_sha256 ({
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
