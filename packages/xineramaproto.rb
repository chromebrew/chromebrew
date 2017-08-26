require 'package'

class Xineramaproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.2'
  source_url 'https://www.x.org/archive/individual/proto/xineramaproto-1.2.tar.gz'
  source_sha256 'd1298f7e3bea0790bd3c93516b83ff4551b20b544c50fd231d53fc4b5ba93100'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xineramaproto-1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xineramaproto-1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xineramaproto-1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xineramaproto-1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c3ed560e2c214c68df831f59a75cd7b28d723349d9fd9f1f8fb8e9a0afa39ff2',
     armv7l: 'c3ed560e2c214c68df831f59a75cd7b28d723349d9fd9f1f8fb8e9a0afa39ff2',
       i686: '8f3cd96fdd1f1de32d1e4cb20efc638705965f844ed361cb3b5e4098c91cd4e4',
     x86_64: 'bcfbe367111452791c31c42e91ced9f875295da9ee09af67390c9bcb4b1e94e3',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
