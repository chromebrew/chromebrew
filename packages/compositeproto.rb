require 'package'

class Compositeproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '0.4'
  source_url 'https://www.x.org/archive/individual/proto/compositeproto-0.4.tar.gz'
  source_sha256 '1607f58409185203077de59801970b07a36f41e586a499918284c8d768d870cc'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/compositeproto-0.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/compositeproto-0.4-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/compositeproto-0.4-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/compositeproto-0.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e9378ece79e1ad5756086242df883ea1642cec69d3c9418c80d26e681d403b2f',
     armv7l: 'e9378ece79e1ad5756086242df883ea1642cec69d3c9418c80d26e681d403b2f',
       i686: 'a23c23301e800fe5e3299e70c77856ce6f041b5bafc5b5af550ee786f418259c',
     x86_64: 'e111f0ea71ac2c54ab8c68744295ab90dce69b17f59c8f0ea568b9f23f105693',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
