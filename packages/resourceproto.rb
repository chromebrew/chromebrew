require 'package'

class Resourceproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.2.0-0'
  source_url 'https://www.x.org/archive/individual/proto/resourceproto-1.2.0.tar.gz'
  source_sha256 '469029d14fdeeaa7eed1be585998ff4cb92cf664f872d1d69c04140815b78734'

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
