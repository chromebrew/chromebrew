require 'package'

class Compositeproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '0.4-0'
  source_url 'https://www.x.org/archive/individual/proto/compositeproto-0.4.tar.gz'
  source_sha256 '1607f58409185203077de59801970b07a36f41e586a499918284c8d768d870cc'

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
