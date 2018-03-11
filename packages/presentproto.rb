require 'package'

class Presentproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.1-0'
  source_url 'https://www.x.org/archive/individual/proto/presentproto-1.1.tar.gz'
  source_sha256 '114252e97afb4dfae8b31e6b0d5e24e4babda26b364e2be57abc2f3c30248b87'

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
