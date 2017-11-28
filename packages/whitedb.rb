require 'package'

class Whitedb < Package
  description 'Lightweight NoSQL database library operaring fully in main memory'
  homepage 'http://whitedb.org'
  version '0.7.3'
  source_url 'https://whitedb.org/whitedb-0.7.3.tar.gz'
  source_sha256 '10c4ccd754ed2d53dbdef9ec16c88c732aa73d923fc0ee114e7e3a78a812849d'

  binary_url ({
  })
  binary_sha256 ({
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
