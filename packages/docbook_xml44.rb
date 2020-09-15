require 'package'

class Docbook_xml44 < Package
  description 'Version 4.4 - document type definitions for verification of XML data files against the DocBook rule set'
  compatibility 'all'
  homepage 'http://www.docbook.org'
  version '4.4'
  source_url 'http://www.oasis-open.org/docbook/xml/4.4/docbook-xml-4.4.zip'
  source_sha256 '02f159eb88c4254d95e831c51c144b1863b216d909b5ff45743a1ce6f5273090'

  depends_on 'docbook_xml51'
  depends_on 'docbook_xsl'
  
  def self.prebuild
    system "cat << EOF > ./remove_add.sh
sed -i -e 's,<!-- .* -->,,g' #{CREW_PREFIX}/etc/xml/catalog.xml
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook remove public '-//OASIS//DTD DocBook XML V4.4//EN'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook add public '-//OASIS//DTD DocBook XML V4.4//EN' '#{CREW_PREFIX}/share/xml/docbook/4.4/catalog.xml'
EOF"
    system "bash ./remove_add.sh"
  end
  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
    FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
  end
end
