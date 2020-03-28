require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.6.9'
  source_url 'https://www.x.org/archive/individual/lib/libX11-1.6.9.tar.bz2'
  source_sha256 '9cc7e8d000d6193fa5af580d50d689380b8287052270f5bb26a5fb6b58b2bed1'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'xorg_proto'
  depends_on 'libxcb'
  depends_on 'libxtrans'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
