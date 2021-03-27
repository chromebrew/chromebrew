require 'package'

class Docbook_xml < Package
  description 'Meta package for all versions of docbook_xml'
  homepage 'http://www.docbook.org'
  version '5.1-2'
  license 'MIT'
  compatibility 'all'

  is_fake

  FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/env.d/"
  @env = <<~EOF
    # Docbook_xml configuration
    XML_CATALOG_FILES=#{CREW_PREFIX}/etc/xml/catalog
  EOF
  IO.write("#{CREW_DEST_PREFIX}/etc/env.d/docbook_xml", @env)

  depends_on 'xmlcatmgr'
  depends_on 'docbook_xml412'
  depends_on 'docbook_xml42'
  depends_on 'docbook_xml43'
  depends_on 'docbook_xml44'
  depends_on 'docbook_xml45'
  depends_on 'docbook_xml50'
  depends_on 'docbook_xml51'
  # These are probably needed at the same time too.
  depends_on 'docbook_xsl'
  depends_on 'docbook_xsl_nons'
end
