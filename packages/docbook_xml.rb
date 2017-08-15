require 'package'

# from LFS: http://www.linuxfromscratch.org/blfs/view/cvs/pst/docbook.html

class Docbook_xml < Package
  description 'document type definitions for verification of XML data files against the DocBook rule set'
  homepage 'http://www.docbook.org'
  version '4.3'
  source_url 'http://www.docbook.org/xml/4.3/docbook-xml-4.3.zip'
  source_sha256 '23068a94ea6fd484b004c5a73ec36a66aa47ea8f0d6b62cc1695931f5c143464'

  depends_on 'unzip'
  depends_on 'libxml2'
  depends_on 'docbook'

  def self.build
  end

  def self.install
    system "install -v -d -m755 #{CREW_DEST_DIR}/usr/local/share/xml/docbook/xml-dtd-4.3"
    system "install -v -d -m755 #{CREW_DEST_DIR}/usr/local/etc/xml"
    system "cp -v -af docbook.cat *.dtd ent/ *.mod #{CREW_DEST_DIR}/usr/local/share/xml/docbook/xml-dtd-4.3"
    
    system "if [ ! -e #{CREW_DEST_DIR}/usr/local/etc/xml/docbook ]; then
                xmlcatalog --noout --create #{CREW_DEST_DIR}/usr/local/etc/xml/docbook
            fi &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//DTD DocBook XML V4.3//EN' \
                'http://www.oasis-open.org/docbook/xml/4.3/docbookx.dtd' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//DTD DocBook XML CALS Table Model V4.3//EN' \
                'file:///usr/local/share/xml/docbook/xml-dtd-4.3/calstblx.dtd' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//DTD XML Exchange Table Model 19990315//EN' \
                'file:///usr/local/share/xml/docbook/xml-dtd-4.3/soextblx.dtd' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ELEMENTS DocBook XML Information Pool V4.3//EN' \
                'file:///usr/local/share/xml/docbook/xml-dtd-4.3/dbpoolx.mod' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.3//EN' \
                'file:///usr/local/share/xml/docbook/xml-dtd-4.3/dbhierx.mod' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ELEMENTS DocBook XML HTML Tables V4.3//EN' \
                'file:///usr/local/share/xml/docbook/xml-dtd-4.3/htmltblx.mod' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ENTITIES DocBook XML Notations V4.3//EN' \
                'file:///usr/local/share/xml/docbook/xml-dtd-4.3/dbnotnx.mod' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ENTITIES DocBook XML Character Entities V4.3//EN' \
                'file:///usr/local/share/xml/docbook/xml-dtd-4.3/dbcentx.mod' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ENTITIES DocBook XML Additional General Entities V4.3//EN' \
                'file:///usr/local/share/xml/docbook/xml-dtd-4.3/dbgenent.mod' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/docbook &&
            xmlcatalog --noout --add 'rewriteSystem' \
                'http://www.oasis-open.org/docbook/xml/4.3' \
                'file:///usr/local/share/xml/docbook/xml-dtd-4.3' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/docbook &&
            xmlcatalog --noout --add 'rewriteURI' \
                'http://www.oasis-open.org/docbook/xml/4.3' \
                'file:///usr/local/share/xml/docbook/xml-dtd-4.3' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/docbook"
    
    system "if [ ! -e #{CREW_DEST_DIR}/usr/local/etc/xml/catalog ]; then
                xmlcatalog --noout --create #{CREW_DEST_DIR}/usr/local/etc/xml/catalog
            fi &&
            xmlcatalog --noout --add 'delegatePublic' \
                '-//OASIS//ENTITIES DocBook XML' \
                'file:///usr/local/etc/xml/docbook' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/catalog &&
            xmlcatalog --noout --add 'delegatePublic' \
                '-//OASIS//DTD DocBook XML' \
                'file:///usr/local/etc/xml/docbook' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/catalog &&
            xmlcatalog --noout --add 'delegateSystem' \
                'http://www.oasis-open.org/docbook/' \
                'file:///usr/local/etc/xml/docbook' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/catalog &&
            xmlcatalog --noout --add 'delegateURI' \
                'http://www.oasis-open.org/docbook/' \
                'file:///usr/local/etc/xml/docbook' \
                #{CREW_DEST_DIR}/usr/local/etc/xml/catalog"
  end
end
