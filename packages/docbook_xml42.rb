require 'package'

class Docbook_xml42 < Package
  description 'Version 4.2 - document type definitions for verification of XML data files against the DocBook rule set'
  compatibility 'all'
  homepage 'http://www.docbook.org'
  version '4.2'
  source_url 'http://www.oasis-open.org/docbook/xml/4.2/docbook-xml-4.2.zip'
  source_sha256 'acc4601e4f97a196076b7e64b368d9248b07c7abf26b34a02cca40eeebe60fa2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml42-4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml42-4.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml42-4.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml42-4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3f0deabad453e1c61893206ec60921ec1a1fbb2ea76f22bd144a9bfa932a40a1',
     armv7l: '3f0deabad453e1c61893206ec60921ec1a1fbb2ea76f22bd144a9bfa932a40a1',
       i686: '6166d954c4ae7d0832213fa924e2c17b2b211c8b3a95caab6f708219a114bc7b',
     x86_64: '6864f9733627d85e8088c87dc098a74ad3d1d6503c28e3b6c2ed78f3ac57dde6',
  })

  depends_on 'docbook_xml51'
  depends_on 'docbook_xsl' # Requires the catalog.xml created within this package

  def self.prebuild
    system "cat << EOF > ./remove_add.sh
sed -i -e 's,<!-- .* -->,,g' #{CREW_PREFIX}/etc/xml/catalog.xml
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook.xml remove public '-//OASIS//DTD DocBook XML V4.2//EN'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook.xml remove public '-//OASIS//DTD DocBook XML V4.1.2//EN'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook.xml add public '-//OASIS//DTD DocBook XML V4.2//EN' 'file://#{CREW_PREFIX}/share/xml/docbook/4.2/catalog.xml'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook.xml add public '-//OASIS//DTD DocBook XML V4.1.2//EN' 'file://#{CREW_PREFIX}/share/xml/docbook/4.2/catalog.xml'
EOF"
    system 'bash ./remove_add.sh'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
  end
end

