require 'package'

class Xcb_proto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.14'
  source_url 'https://www.x.org/archive/individual/xcb/xcb-proto-1.14.tar.xz'
  source_sha256 '186a3ceb26f9b4a015f5a44dcc814c93033a5fc39684f36f1ecc79834416a605'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xcb_proto-1.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5b8707e7904fcbc6cbbc2ca2c8fa87cad36c354eb1055e912ae127f5cfd4163c',
     armv7l: '5b8707e7904fcbc6cbbc2ca2c8fa87cad36c354eb1055e912ae127f5cfd4163c',
       i686: 'ecd7091cf0089fcb0b3b66c431a607e441cb9029d4e37f272ac548857b50b80a',
     x86_64: 'a4de2e1bdf7aacee5904d9854d365e87f87eff754fc8201341595788bd5bb686',
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
