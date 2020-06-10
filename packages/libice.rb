require 'package'

class Libice < Package
  description 'X.org X Inter Client Exchange Library'
  homepage 'http://www.x.org'
  version '1.0.9-0'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libICE-1.0.9.tar.gz'
  source_sha256 '7812a824a66dd654c830d21982749b3b563d9c2dfe0b88b203cefc14a891edc0'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libice-1.0.9-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libice-1.0.9-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libice-1.0.9-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libice-1.0.9-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9950466b86446a797a1331d6778a5d339af17960cad8c2c9a8e5a038c63c5b57',
     armv7l: '9950466b86446a797a1331d6778a5d339af17960cad8c2c9a8e5a038c63c5b57',
       i686: 'b5591b7c29b39dc1490481990590ca062f62ca717a0decdd342f8b1ce62a7145',
     x86_64: 'f12df0a9802c23816595d13ddaa15ca46727b9ace7c7f57ede4cdbcc1ecbd8f8',
  })

  depends_on 'libxtrans'
  depends_on 'libx11'
  depends_on 'libbsd'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
