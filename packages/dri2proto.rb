require 'package'

class Dri2proto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.8'
  source_url 'https://www.x.org/archive/individual/proto/dri2proto-2.8.tar.gz'
  source_sha256 '7e65b031eaa6ebe23c75583d4abd993ded7add8009b4200a4db7aa10728b0f61'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dri2proto-2.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dri2proto-2.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dri2proto-2.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dri2proto-2.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '661fcce3be8411e0c850d452472796595ea49253e2e7a250f321ad82b87ff317',
     armv7l: '661fcce3be8411e0c850d452472796595ea49253e2e7a250f321ad82b87ff317',
       i686: '54b62360cc347c7b039329afb84c3fa3c496cd7ff359537a94aa38edcd5ebc25',
     x86_64: '1e5940de322be9369e8a249cb2ffe98b20798f82e0bc8a2f7b415f077986491b',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
