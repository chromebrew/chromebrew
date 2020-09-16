require 'package'

class Docbook_xml44 < Package
  description 'Version 4.4 - document type definitions for verification of XML data files against the DocBook rule set'
  compatibility 'all'
  homepage 'http://www.docbook.org'
  version '4.4'
  source_url 'http://www.oasis-open.org/docbook/xml/4.4/docbook-xml-4.4.zip'
  source_sha256 '02f159eb88c4254d95e831c51c144b1863b216d909b5ff45743a1ce6f5273090'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml44-4.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml44-4.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml44-4.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml44-4.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f56b6c50394ce4ba7cc71097954872461835a2f4502c133b6ca9d815821caa0c',
     armv7l: 'f56b6c50394ce4ba7cc71097954872461835a2f4502c133b6ca9d815821caa0c',
       i686: 'c285506ebd3e12e15c03907e6d289f5a8d60e98e76175119960c9b9c78c687b3',
     x86_64: 'bce18b425d7180f3cf1d1f3b4a1b4aba30916ed0743bc38b126857d9e92ea45a',
  })

  depends_on 'docbook_xml51'
  depends_on 'docbook_xsl'
  
  def self.prebuild
    system "cat << EOF > ./remove_add.sh
sed -i -e 's,<!-- .* -->,,g' #{CREW_PREFIX}/etc/xml/catalog.xml
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook.xml remove public '-//OASIS//DTD DocBook XML V4.4//EN'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook.xml add public '-//OASIS//DTD DocBook XML V4.4//EN' 'file://#{CREW_PREFIX}/share/xml/docbook/4.4/catalog.xml'
EOF"
    system 'bash ./remove_add.sh'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
  end
end
