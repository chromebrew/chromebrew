require 'package'

class Resourceproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.2.0'
  source_url 'https://www.x.org/archive/individual/proto/resourceproto-1.2.0.tar.gz'
  source_sha256 '469029d14fdeeaa7eed1be585998ff4cb92cf664f872d1d69c04140815b78734'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/resourceproto-1.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/resourceproto-1.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/resourceproto-1.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/resourceproto-1.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '84eea3e9fae6e7a16a9b672ee8d7c3d649ffa32aee70fa13d50c4951f19b755e',
     armv7l: '84eea3e9fae6e7a16a9b672ee8d7c3d649ffa32aee70fa13d50c4951f19b755e',
       i686: '7edd4260aa6abbc97b75c293a555ca32c8e0b5ef23b04609f01e3d378191d922',
     x86_64: '17064a6eba7852e62e8660ef8d01fd040b22cfbc95f7a1ab98504a13d3064d21',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
