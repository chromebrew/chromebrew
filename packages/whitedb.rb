require 'package'

class Whitedb < Package
  description 'Lightweight NoSQL database library operaring fully in main memory'
  homepage 'http://whitedb.org'
  version '0.7.3'
  compatibility 'all'
  source_url 'https://whitedb.org/whitedb-0.7.3.tar.gz'
  source_sha256 '10c4ccd754ed2d53dbdef9ec16c88c732aa73d923fc0ee114e7e3a78a812849d'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/whitedb-0.7.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/whitedb-0.7.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/whitedb-0.7.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/whitedb-0.7.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e27c9bcfd7733bed9ad37fa39295e3b1f45f147c6c1e3864263092a277a175fc',
     armv7l: 'e27c9bcfd7733bed9ad37fa39295e3b1f45f147c6c1e3864263092a277a175fc',
       i686: '9f67c9dfd8314d203df73d13f6eb7700c92bea7e03228f7096994979503d4125',
     x86_64: 'eda584a55d77f6fda81ed0266ce0c43da1c77591a1576b9a866dd73b5df28782',
  })

  def self.build
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-depedency-tracking'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
