require 'package'

class Libpciaccess < Package
  description 'Generic PCI access library'
  homepage 'https://x.org'
  version '0.13-0'
  source_url 'https://www.x.org/archive/individual/lib/libpciaccess-0.13.tar.gz'
  source_sha256 'afdfe55b23be710751b630073127febef498af35d4a58944fccbef860315f72c'

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
