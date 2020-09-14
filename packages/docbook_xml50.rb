require 'package'

class Docbook_xml50 < Package
  description 'Version 50 - document type definitions for verification of XML data files against the DocBook rule set'
  compatibility 'all'
  homepage 'http://www.docbook.org'
  version '5.0'
  source_url 'https://docbook.org/xml/5.0/docbook-5.0.zip'
  source_sha256 '3dcd65e1f5d9c0c891b3be204fa2bb418ce485d32310e1ca052e81d36623208e'

  depends_on 'docbook_xml51'
  depends_on 'docbook_xsl'
  
  def self.prebuild
    system "sed -i -e 's,<!-- .* -->,,g' #{CREW_PREFIX}/etc/xml/catalog.xml"
    system "cat << EOF > ./remove_add.sh
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook remove public '-//OASIS//DTD DocBook XML V5.0//EN'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook add public '-//OASIS//DTD DocBook XML V5.0//EN' '#{CREW_PREFIX}/share/xml/docbook/5.0/catalog.xml'
EOF"
    system "bash ./remove_add.sh"
  end
  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
    FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
  end
end
