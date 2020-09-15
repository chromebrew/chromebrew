require 'package'

class Docbook_xml45 < Package
  description 'Version 4.5 -document type definitions for verification of XML data files against the DocBook rule set'
  compatibility 'all'
  homepage 'http://www.docbook.org'
  version '4.5'
  source_url 'http://www.oasis-open.org/docbook/xml/4.5/docbook-xml-4.5.zip'
  source_sha256 '4e4e037a2b83c98c6c94818390d4bdd3f6e10f6ec62dd79188594e26190dc7b4'

  depends_on 'docbook_xml51'
  depends_on 'docbook_xsl'
  
  def self.prebuild
    system "cat << EOF > ./remove_add.sh
sed -i -e 's,<!-- .* -->,,g' #{CREW_PREFIX}/etc/xml/catalog.xml
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook remove public '-//OASIS//DTD DocBook XML V4.5//EN'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook add public '-//OASIS//DTD DocBook XML V4.5//EN' '#{CREW_PREFIX}/share/xml/docbook/4.5/catalog.xml'
EOF"
    system "bash ./remove_add.sh"
  end
  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
    FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
  end
end

