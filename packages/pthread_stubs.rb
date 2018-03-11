require 'package'

class Pthread_stubs < Package
  description 'pthread stubs to get libX11 working'
  homepage 'https://x.org'
  version '0.1-0'
  source_url 'https://www.x.org/archive/individual/lib/libpthread-stubs-0.1.tar.gz'
  source_sha256 'f8f7ca635fa54bcaef372fd5fd9028f394992a743d73453088fcadc1dbf3a704'

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
