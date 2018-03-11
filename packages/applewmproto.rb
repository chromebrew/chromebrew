require 'package'

class Applewmproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.4.2-0'
  source_url 'https://www.x.org/archive/individual/proto/applewmproto-1.4.2.tar.gz'
  source_sha256 'ff8ac07d263a23357af2d6ff0cca3c1d56b043ddf7797a5a92ec624f4704df2e'

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
