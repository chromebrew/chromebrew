require 'package'

class Docbook_xml43 < Package
  description 'document type definitions for verification of XML data files against the DocBook rule set'
  compatibility 'all'
  homepage 'http://www.docbook.org'
  version '4.3'
  source_url 'http://www.oasis-open.org/docbook/xml/4.3/docbook-xml-4.3.zip'
  source_sha256 '23068a94ea6fd484b004c5a73ec36a66aa47ea8f0d6b62cc1695931f5c143464'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml43-4.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml43-4.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml43-4.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml43-4.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7c4339228b5d7840b588aa434e3bfaf22830a3479e1f8edb166384a1ec61d8c4',
     armv7l: '7c4339228b5d7840b588aa434e3bfaf22830a3479e1f8edb166384a1ec61d8c4',
       i686: '7dd4c1bc19666b1932f451e1ca90c7e13820149b0ff4b80c31bb850128bfdb9c',
     x86_64: '56826d7a6b5abde5b17f1df6f32d6b97222f6e00c4f8fc0b50bfb1467489a208',
  })

  depends_on 'docbook'
  depends_on 'xmlcatmgr'
  depends_on 'docbook_xml'
  depends_on 'docbook_xsl'

  def self.prebuild
    system "cat << EOF > ./remove_add.sh
sed -i -e 's,<!-- .* -->,,g' #{CREW_PREFIX}/etc/xml/catalog.xml
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook.xml remove public '-//OASIS//DTD DocBook XML V4.3//EN'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook.xml add public '-//OASIS//DTD DocBook XML V4.3//EN' 'file://#{CREW_PREFIX}/share/xml/docbook/4.3/catalog.xml'
EOF"
    system 'bash ./remove_add.sh'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/4.3/"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/xml/docbook/4.3/"
  end
end

