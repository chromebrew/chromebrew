require 'package'

class Docbook_xml < Package
  description 'Meta package for all versions of docbook_xml'
  compatibility 'all'
  homepage 'http://www.docbook.org'
  version '5.1-2'

  is_fake

  # Docbook common postinstall block
  ENV['XML_CATALOG_FILES'] = "#{CREW_PREFIX}/etc/xml/catalog"

  xml_catalog_files_in_bashrc = `grep -c "XML_CATALOG_FILES" ~/.bashrc || true`
  unless xml_catalog_files_in_bashrc.to_i.positive?
    puts "Putting \"export XML_CATALOG_FILES=#{CREW_PREFIX}/etc/xml/catalog\" in ~/.bashrc".lightblue
    system "echo 'export XML_CATALOG_FILES=#{CREW_PREFIX}/etc/xml/catalog' >> ~/.bashrc"
    puts 'To complete the installation, execute the following:'.orange
    puts 'source ~/.bashrc'.orange
  end
  # End Docbook common postinstall block

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
