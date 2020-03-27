require 'package'

class Libxtrans < Package
  description 'transpot library for the X window system'
  homepage 'https://x.org'
  version '1.4.0'
  source_url 'https://www.x.org/archive/individual/lib/xtrans-1.4.0.tar.bz2'
  source_sha256 '377c4491593c417946efcd2c7600d1e62639f7a8bbca391887e2c4679807d773'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
