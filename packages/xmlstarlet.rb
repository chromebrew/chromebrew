require 'package'

class Xmlstarlet < Package
  description 'XMLStarlet is a command line XML toolkit which can be used to transform, query, validate, and edit XML documents and files using simple set of shell commands in similar way it is done for plain text files using grep/sed/awk/tr/diff/patch.'
  homepage 'http://xmlstar.sourceforge.net/'
  version '1.6.1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/xmlstar/xmlstarlet/1.6.1/xmlstarlet-1.6.1.tar.gz'
  source_sha256 '15d838c4f3375332fd95554619179b69e4ec91418a3a5296e7c631b7ed19e7ca'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xmlstarlet-1.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xmlstarlet-1.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xmlstarlet-1.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xmlstarlet-1.6.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c8cf483394228f94ee8c592285ed257e5b62aa839bb9ad901da0a6efbfa3b534',
     armv7l: 'c8cf483394228f94ee8c592285ed257e5b62aa839bb9ad901da0a6efbfa3b534',
       i686: '07bea6a674ccca26c89993da5ec70f8d3ebd94717fa8ee34cbe37ba420984fb2',
     x86_64: 'da8c6a886a440e4fc4237cb47c9944ad18f0e41765b478fdba22e6b692faf2b8',
  })

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
