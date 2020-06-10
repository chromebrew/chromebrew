require 'package'

class Docbook < Package
  description 'DocBook is an XML vocabulary that lets you create documents in a presentation-neutral form that captures the logical structure of your content.'
  homepage 'http://docbook.sourceforge.net/'
  version '1.79.1-1'
  compatibility 'all'
  source_url 'https://prdownloads.sourceforge.net/project/docbook/docbook-xsl/1.79.1/docbook-xsl-1.79.1.tar.bz2'
  source_sha256 '725f452e12b296956e8bfb876ccece71eeecdd14b94f667f3ed9091761a4a968'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook-1.79.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docbook-1.79.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docbook-1.79.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook-1.79.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '478699b1b1daf061aa64cb71ae22c504d4901aac407525574d48d36cd4f085e4',
     armv7l: '478699b1b1daf061aa64cb71ae22c504d4901aac407525574d48d36cd4f085e4',
       i686: 'bbea3f2d4dbfff96e903d4ba085d1b7242e490b415f6ce629abd1f9046852596',
     x86_64: 'dd7a1d8bee46badac46d233176bc660d47c56cb9e3b4488b6107661bda90e83e',
  })

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/docbook"
    system "cp -r . #{CREW_DEST_PREFIX}/docbook"
  end
end
