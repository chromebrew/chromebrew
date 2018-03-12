require 'package'

class Fontsproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.1.3-0'
  source_url 'https://www.x.org/archive/individual/proto/fontsproto-2.1.3.tar.gz'
  source_sha256 '72c44e63044b2b66f6fa112921621ecc20c71193982de4f198d9a29cda385c5e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fontsproto-2.1.3-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fontsproto-2.1.3-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fontsproto-2.1.3-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fontsproto-2.1.3-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: '24583a4ddd8b4c2e1e9b338712821fe9b1d14eff10c9ca0facd3131fe379a212',
     armv7l: '24583a4ddd8b4c2e1e9b338712821fe9b1d14eff10c9ca0facd3131fe379a212',
       i686: 'aee418ec8a005013bbad0f33ec3ba9aad79eba94256d54b32dcc8e864c6fd7cd',
     x86_64: '9281a8d826ce656cbc73ceeae5903f23fa50c92ff8af78cb1ea2fd48df7768c4',

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
