require 'package'

class Printproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.0.5'
  source_url 'https://www.x.org/archive/individual/proto/printproto-1.0.5.tar.gz'
  source_sha256 'e8b6f405fd865f0ea7a3a2908dfbf06622f57f2f91359ec65d13b955e49843fc'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/printproto-1.0.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/printproto-1.0.5-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/printproto-1.0.5-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/printproto-1.0.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b6abd75c11c4d440254cb3ac85bca9e2822a3f0322e1979490c0c913df3be234',
     armv7l: 'b6abd75c11c4d440254cb3ac85bca9e2822a3f0322e1979490c0c913df3be234',
       i686: 'dbf8f705fa7477a597073cf08a19d2a9b9afda07e2f6dfb680b7a323648a2f81',
     x86_64: '33f8e9b60625f45d96f4b687a40b6e8b31e132d1e3b1522fea28c98a9007d78a',
  })

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
