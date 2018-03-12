require 'package'

class Presentproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.1-0'
  source_url 'https://www.x.org/archive/individual/proto/presentproto-1.1.tar.gz'
  source_sha256 '114252e97afb4dfae8b31e6b0d5e24e4babda26b364e2be57abc2f3c30248b87'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/presentproto-1.1-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/presentproto-1.1-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/presentproto-1.1-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/presentproto-1.1-0-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: 'b448f09c7e6973d8f939576687021a7e0e860d5e71bb27b1cd88ad76ce5b390e',
     armv7l: 'b448f09c7e6973d8f939576687021a7e0e860d5e71bb27b1cd88ad76ce5b390e',
       i686: 'ebb3db9ab7d67fabba4b1c71473915649ef06ee530803bf01ff65afa86a1d29b',
     x86_64: '47198cc541ba6c2cfce532e5630127c681cef383b6b3a3ffe5c62bf61ac5886a',

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
