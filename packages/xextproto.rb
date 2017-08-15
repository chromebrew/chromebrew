require 'package'

class Xextproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '7.3.0'
  source_url 'https://www.x.org/archive/individual/proto/xextproto-7.3.0.tar.gz'
  source_sha256 '1b1bcdf91221e78c6c33738667a57bd9aaa63d5953174ad8ed9929296741c9f5'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/xextproto-7.3.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/xextproto-7.3.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/xextproto-7.3.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/xextproto-7.3.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4994b28def9036dc15942a35ad60628b47837abc8614c439e1326da1575dc5f0',
     armv7l: '4994b28def9036dc15942a35ad60628b47837abc8614c439e1326da1575dc5f0',
       i686: 'd38169400b6cd4affd98feebdcd2bc8df225181a936ce63b8b9f5dd8467919ca',
     x86_64: '0ec9be9adf73b0f2803831f338bd8b3264bc34b566f7d64d808c4de2748b5f31',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
