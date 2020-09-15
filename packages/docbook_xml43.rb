require 'package'

class Docbook_xml43 < Package
  description 'document type definitions for verification of XML data files against the DocBook rule set'
  compatibility 'all'
  homepage 'http://www.docbook.org'
  version '4.3'
  source_url 'http://www.oasis-open.org/docbook/xml/4.3/docbook-xml-4.3.zip'
  source_sha256 '23068a94ea6fd484b004c5a73ec36a66aa47ea8f0d6b62cc1695931f5c143464'

  depends_on 'docbook'
  depends_on 'xmlcatmgr'
  depends_on 'docbook_xml'
  depends_on 'docbook_xsl'
  
  def self.prebuild
    system "cat << EOF > ./remove_add.sh
sed -i -e 's,<!-- .* -->,,g' #{CREW_PREFIX}/etc/xml/catalog.xml
xmlcatmgr -c #{CREW_PREFIX}/xml/docbook remove public '-//OASIS//DTD DocBook XML V4.3//EN'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook add public '-//OASIS//DTD DocBook XML V4.3//EN' '#{CREW_PREFIX}/share/xml/docbook/4.3/catalog.xml'
EOF"
    system "bash ./remove_add.sh"
  end
  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/4.3/"
    FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/xml/docbook/4.3/"
  end
end

