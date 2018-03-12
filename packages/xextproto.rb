require 'package'

class Xextproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '7.3.0-0'
  source_url 'https://www.x.org/archive/individual/proto/xextproto-7.3.0.tar.gz'
  source_sha256 '1b1bcdf91221e78c6c33738667a57bd9aaa63d5953174ad8ed9929296741c9f5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xextproto-7.3.0-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xextproto-7.3.0-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xextproto-7.3.0-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xextproto-7.3.0-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: 'db9ac3a054262e35cc7983f36ba5dc8d581c517e10f9344ed7809d22df218430',
     armv7l: 'db9ac3a054262e35cc7983f36ba5dc8d581c517e10f9344ed7809d22df218430',
       i686: '9631921974c4f67e2cac1dc49d55565a9115a6c12f7aa289ae60ebe6f08769fd',
     x86_64: 'ae3f636d9945819b5998c7d719c1734a4bd730e6bf7c9ff82aa03af3a29c60f3',

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
