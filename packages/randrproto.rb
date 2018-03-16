require 'package'

class Randrproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '1.5.0-0'
  source_url 'https://www.x.org/archive/individual/proto/randrproto-1.5.0.tar.gz'
  source_sha256 '8f8a716d6daa6ba05df97d513960d35a39e040600bf04b313633f11679006fab'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/randrproto-1.5.0-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/randrproto-1.5.0-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/randrproto-1.5.0-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/randrproto-1.5.0-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4301a3736d9e2004f54a41c7400d75eccb439171321fe7ebfec00b96f54db550',
     armv7l: '4301a3736d9e2004f54a41c7400d75eccb439171321fe7ebfec00b96f54db550',
       i686: 'b55e320c2a6cb2ccbb638f9cb65286b398968d8db1602dc3e1e370023a2ad2bb',
     x86_64: '075ec3e2d18dec81b117e9853c0af8ded763242d7360b49b7bc3579f6365a0c9',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
