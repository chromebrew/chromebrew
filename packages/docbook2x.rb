require 'package'

class Docbook2x < Package
  description 'docbook2X is a software package that converts DocBook documents into the traditional Unix man page format and the GNU Texinfo format.'
  homepage 'http://docbook2x.sourceforge.net/'
  version '0.8.8'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/docbook2x/docbook2x/0.8.8/docbook2X-0.8.8.tar.gz'
  source_sha256 '4077757d367a9d1b1427e8d5dfc3c49d993e90deabc6df23d05cfe9cd2fcdc45'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook2x-0.8.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docbook2x-0.8.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docbook2x-0.8.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook2x-0.8.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '908f22bd15b5d8cd5d4ebc09f9ee7cd2f7bbbf83a0b359c899983c83a0437a2e',
     armv7l: '908f22bd15b5d8cd5d4ebc09f9ee7cd2f7bbbf83a0b359c899983c83a0437a2e',
       i686: '06a3b6ea1ada68b8bf1b8b2b7f2d2112bff3c26da0f6900c4b4bc8aeda20b8c9',
     x86_64: 'dca6f49d1bae407301a334edbde810845fa2aa6e2000b1cd1d658aac681cbdbe',
  })

  depends_on 'perl_xml_sax_parserfactory'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
