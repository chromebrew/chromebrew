require 'package'

class Dmxproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.3'
  source_url 'https://www.x.org/archive/individual/proto/dmxproto-2.3.tar.gz'
  source_sha256 'a911a086a61c1bb16d35f70b391f167744ee721b5e2a7f22c00bc5a2c1ecb242'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dmxproto-2.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dmxproto-2.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dmxproto-2.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dmxproto-2.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cb7a11e41ed58031979964b1d74daf6d1d1a3fffaf109d83d33099257415d4db',
     armv7l: 'cb7a11e41ed58031979964b1d74daf6d1d1a3fffaf109d83d33099257415d4db',
       i686: '6d72ac097f38aec3fea9b1e7459ca63687db48b18aeb6244b1f4021c66bdb71b',
     x86_64: 'ff140f170545e997aaf0237f54eb2446aa0f30610e9604c25c150f864154731a',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
