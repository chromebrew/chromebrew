require 'package'

class Printproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.0.5-0'
  source_url 'https://www.x.org/archive/individual/proto/printproto-1.0.5.tar.gz'
  source_sha256 'e8b6f405fd865f0ea7a3a2908dfbf06622f57f2f91359ec65d13b955e49843fc'

  binary_url ({

  })
  binary_sha256 ({

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
