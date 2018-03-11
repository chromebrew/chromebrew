require 'package'

class Randrproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.5.0-0'
  source_url 'https://www.x.org/archive/individual/proto/randrproto-1.5.0.tar.gz'
  source_sha256 '8f8a716d6daa6ba05df97d513960d35a39e040600bf04b313633f11679006fab'

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
