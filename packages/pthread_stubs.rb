require 'package'

class Pthread_stubs < Package
  description 'pthread stubs to get libX11 working'
  homepage 'https://x.org'
  version '0.4'
  source_url 'https://xcb.freedesktop.org/dist/libpthread-stubs-0.4.tar.bz2'
  source_sha256 'e4d05911a3165d3b18321cc067fdd2f023f06436e391c6a28dff618a78d2e733'

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
