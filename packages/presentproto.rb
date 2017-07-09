require 'package'

class Presentproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.1'
  source_url 'https://www.x.org/archive/individual/proto/presentproto-1.1.tar.gz'
  source_sha256 '114252e97afb4dfae8b31e6b0d5e24e4babda26b364e2be57abc2f3c30248b87'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/presentproto-1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/presentproto-1.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/presentproto-1.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/presentproto-1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '051543d38a4a7cec85ed136faef62c86914c734261e4d97c4f4a67577633c6f3',
     armv7l: '051543d38a4a7cec85ed136faef62c86914c734261e4d97c4f4a67577633c6f3',
       i686: 'e173496414ad76b9e1602be74771ed80e4415bf534cc9181a92c8ada54c3ab14',
     x86_64: '56cc87da8485a870801eabf1300a2fb2989167e3a0ad3f8c9ab69f6cfe310f3a',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
