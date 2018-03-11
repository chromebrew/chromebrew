require 'package'

class Dri2proto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.8-0'
  source_url 'https://www.x.org/archive/individual/proto/dri2proto-2.8.tar.gz'
  source_sha256 '7e65b031eaa6ebe23c75583d4abd993ded7add8009b4200a4db7aa10728b0f61'

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
