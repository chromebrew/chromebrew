require 'package'

class Damageproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.2.1'
  source_url 'https://www.x.org/archive/individual/proto/damageproto-1.2.1.tar.gz'
  source_sha256 'f65ccbf1de9750a527ea6e85694085b179f2d06495cbdb742b3edb2149fef303'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/damageproto-1.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/damageproto-1.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/damageproto-1.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/damageproto-1.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e75540a25f67be9d01b88782a5257e9f7958458d77ad069a4aae4a34913099f1',
     armv7l: 'e75540a25f67be9d01b88782a5257e9f7958458d77ad069a4aae4a34913099f1',
       i686: '1570f461f2e003f120bda0729a9a071cef7b59a2b55aecc1cac729cb58cf4ab5',
     x86_64: 'a2490f9bc4e522400157b00d601718eb418a1b66558b144a38eda43d26518c5f',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
