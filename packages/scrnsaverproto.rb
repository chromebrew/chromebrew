require 'package'

class Scrnsaverproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.2.2-0'
  source_url 'https://www.x.org/archive/individual/proto/scrnsaverproto-1.2.2.tar.gz'
  source_sha256 'd8dee19c52977f65af08fad6aa237bacee11bc5a33e1b9b064e8ac1fd99d6e79'

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
