require 'package'

class Dmxproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '2.3-0'
  source_url 'https://www.x.org/archive/individual/proto/dmxproto-2.3.tar.gz'
  source_sha256 'a911a086a61c1bb16d35f70b391f167744ee721b5e2a7f22c00bc5a2c1ecb242'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/dmxproto-2.3-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/dmxproto-2.3-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/dmxproto-2.3-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/dmxproto-2.3-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a6e150081dd982846398d9d2fb4d83e5b254e3997d9bc02bd431e7e042426a85',
     armv7l: 'a6e150081dd982846398d9d2fb4d83e5b254e3997d9bc02bd431e7e042426a85',
       i686: '2f22e737feddb8e70a1093e708734ecae9750204680bee7e9226b0bc9b04d8e4',
     x86_64: 'b47b4acf2dcc24009ccd1f9e3200d2ea0309682e13fc7fcf7d570ae36157f91d',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
