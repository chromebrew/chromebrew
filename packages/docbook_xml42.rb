require 'package'

class Docbook_xml42 < Package
  description 'Version 4.2 - document type definitions for verification of XML data files against the DocBook rule set'
  compatibility 'all'
  homepage 'http://www.docbook.org'
  version '4.2'
  source_url 'http://www.oasis-open.org/docbook/xml/4.2/docbook-xml-4.2.zip'
  source_sha256 'acc4601e4f97a196076b7e64b368d9248b07c7abf26b34a02cca40eeebe60fa2'

  depends_on 'docbook_xml51'
  depends_on 'docbook_xsl' # Requires the catalog.xml created within this package
  
  def self.prebuild
    system "sed -i -e 's,<!-- .* -->,,g' #{CREW_PREFIX}/etc/xml/catalog.xml"
    system "cat << EOF > ./remove_add.sh
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook remove public '-//OASIS//DTD DocBook XML V4.2//EN'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook remove public '-//OASIS//DTD DocBook XML V4.1.2//EN'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook add public '-//OASIS//DTD DocBook XML V4.2//EN' '#{CREW_PREFIX}/share/xml/docbook/4.2/catalog.xml'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook add public '-//OASIS//DTD DocBook XML V4.1.2//EN' '#{CREW_PREFIX}/share/xml/docbook/4.2/catalog.xml'

EOF"
    system "bash ./remove_add.sh"
  end
  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
    FileUtils.cp_r Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
  end
end

