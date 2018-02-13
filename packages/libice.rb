require 'package'

class Libice < Package
  description 'X.org X Inter Client Exchange Library'
  homepage 'http://www.x.org'
  version '1.0.9'
  source_url 'https://www.x.org/archive/individual/lib/libICE-1.0.9.tar.gz'
  source_sha256 '7812a824a66dd654c830d21982749b3b563d9c2dfe0b88b203cefc14a891edc0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libice-1.0.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libice-1.0.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libice-1.0.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libice-1.0.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8ff70756004cfc0d6ac843083989eadae6a34c2545e683e62fb4e2b07e547b4a',
     armv7l: '8ff70756004cfc0d6ac843083989eadae6a34c2545e683e62fb4e2b07e547b4a',
       i686: 'f78ca2bc72fa4ae1357c82949e5c5d82cae5cb1b2df43a7832b8d7bc7bb48a78',
     x86_64: 'd65e2c73d6aaecede6d2df5d74e481f36bcf8e896e6b7f813fca7447316e3e71',
  })

  depends_on 'xproto'
  depends_on 'libxtrans'
  depends_on 'util_macros'  
  depends_on 'libx11'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end