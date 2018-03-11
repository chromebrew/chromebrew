require 'package'

class Xf86vidmodeproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.3-0'
  source_url 'https://www.x.org/archive/individual/proto/xf86vidmodeproto-2.3.tar.gz'
  source_sha256 '4bdb8d868f65783f58d9619232a31a2c309e7ae15d24ce5efc579a732aaa271d'

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
