require 'package'

class Fontsproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.1.3'
  source_url 'https://www.x.org/archive/individual/proto/fontsproto-2.1.3.tar.gz'
  source_sha256 '72c44e63044b2b66f6fa112921621ecc20c71193982de4f198d9a29cda385c5e'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/fontsproto-2.1.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/fontsproto-2.1.3-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/fontsproto-2.1.3-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/fontsproto-2.1.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a29922ecf12e3153d24edefa17f8db27e0067b92fc605ea9c90f5e41c7327be2',
     armv7l: 'a29922ecf12e3153d24edefa17f8db27e0067b92fc605ea9c90f5e41c7327be2',
       i686: '6ffb63f9690efc704a890cdb37c6b1f32c19dbcd728edd9e7b7dca88ba61e633',
     x86_64: '17ab2f6e3163dcfcc7a442120edf94fa73443ebc89bd23fcb450511925cb3b87',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
