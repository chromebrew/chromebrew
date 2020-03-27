require 'package'

class Xcb_proto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.14'
  source_url 'https://www.x.org/archive/individual/xcb/xcb-proto-1.14.tar.xz'
  source_sha256 '186a3ceb26f9b4a015f5a44dcc814c93033a5fc39684f36f1ecc79834416a605'

  binary_url ({
  })
  binary_sha256 ({
  })
  
  depends_on 'python27' => :build 

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
