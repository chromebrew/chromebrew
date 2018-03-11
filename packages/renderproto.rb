require 'package'

class Renderproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '0.11-0'
  source_url 'https://www.x.org/archive/individual/proto/renderproto-0.11.tar.gz'
  source_sha256 '256e4af1d3b4007872a276ed9e5c2522f80f5fe69b97268542917635b4dbf758'

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
