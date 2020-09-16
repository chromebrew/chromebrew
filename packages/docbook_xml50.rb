require 'package'

class Docbook_xml50 < Package
  description 'Version 50 - document type definitions for verification of XML data files against the DocBook rule set'
  compatibility 'all'
  homepage 'http://www.docbook.org'
  version '5.0'
  source_url 'https://docbook.org/xml/5.0/docbook-5.0.zip'
  source_sha256 '3dcd65e1f5d9c0c891b3be204fa2bb418ce485d32310e1ca052e81d36623208e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml50-5.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml50-5.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml50-5.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml50-5.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f8ffcb93e529832869efcaa84bbd38e449ec040d4a8592b2a0ec9a575ce12194',
     armv7l: 'f8ffcb93e529832869efcaa84bbd38e449ec040d4a8592b2a0ec9a575ce12194',
       i686: '68f0e60692f7af3303df137fe4dbad87d39146257c719e968ad8747d2c90f324',
     x86_64: 'fcb2668caca391127e526c0a568ccc3ed0ec0f9903180ebb8483795ed12ea5e6',
  })

  depends_on 'docbook_xml51'
  depends_on 'docbook_xsl'
  
  def self.prebuild
    system "cat << EOF > ./remove_add.sh
sed -i -e 's,<!-- .* -->,,g' #{CREW_PREFIX}/etc/xml/catalog.xml
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook.xml remove public '-//OASIS//DTD DocBook XML V5.0//EN'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook.xml add public '-//OASIS//DTD DocBook XML V5.0//EN' 'file://#{CREW_PREFIX}/share/xml/docbook/5.0/catalog.xml'
EOF"
    system 'bash ./remove_add.sh'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
  end
end
