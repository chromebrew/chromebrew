require 'package'

class Libxau < Package
  description 'xau library for libX11'
  homepage 'https://x.org'
  version '1.0.9'
  source_url 'https://www.x.org/archive/individual/lib/libXau-1.0.9.tar.bz2'
  source_sha256 'ccf8cbf0dbf676faa2ea0a6d64bcc3b6746064722b606c8c52917ed00dcb73ec'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'xorg_proto'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
