require 'package'

# from LFS: http://www.linuxfromscratch.org/blfs/view/cvs/pst/docbook.html

class Docbook_xml < Package
  description 'document type definitions for verification of XML data files against the DocBook rule set'
  homepage 'http://www.docbook.org'
  version '4.3-1'
  source_url 'http://www.docbook.org/xml/4.3/docbook-xml-4.3.zip'
  source_sha256 '23068a94ea6fd484b004c5a73ec36a66aa47ea8f0d6b62cc1695931f5c143464'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'docbook'

  def self.install

    xml_dtd = 'xml-dtd-4.3'
    xml_version = 'xml/4.3'
    vxml = 'V4.3'

    system "install -v -d -m755 #{CREW_DEST_PREFIX}/share/xml/docbook/#{xml_dtd}"
    system "install -v -d -m755 #{CREW_DEST_PREFIX}/etc/xml"
    system "cp -rpa . #{CREW_DEST_PREFIX}/share/xml/docbook/#{xml_dtd}/"
    system "rm -f #{CREW_PREFIX}/etc/xml/docbook && \
                xmlcatalog --noout --create #{CREW_DEST_PREFIX}/etc/xml/docbook && \
            xmlcatalog --noout --add 'public' \
                '-//OASIS//DTD DocBook XML #{vxml}//EN' \
                'http://www.oasis-open.org/docbook/#{xml_version}/docbookx.dtd' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//DTD DocBook XML CALS Table Model #{vxml}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/calstblx.dtd' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//DTD XML Exchange Table Model 19990315//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/soextblx.dtd' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ELEMENTS DocBook XML Information Pool #{vxml}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbpoolx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ELEMENTS DocBook XML Document Hierarchy #{vxml}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbhierx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ELEMENTS DocBook XML HTML Tables #{vxml}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/htmltblx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ENTITIES DocBook XML Notations #{vxml}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbnotnx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ENTITIES DocBook XML Character Entities #{vxml}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbcentx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ENTITIES DocBook XML Additional General Entities #{vxml}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbgenent.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'rewriteSystem' \
                'http://www.oasis-open.org/docbook/#{xml_version}' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'rewriteURI' \
                'http://www.oasis-open.org/docbook/#{xml_version}' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook"
    
    system "rm -f #{CREW_PREFIX}/etc/xml/catalog && \
                xmlcatalog --noout --create #{CREW_DEST_PREFIX}/etc/xml/catalog && \
            xmlcatalog --noout --add 'delegatePublic' \
                '-//OASIS//ENTITIES DocBook XML' \
                'file://#{CREW_PREFIX}/etc/xml/docbook' \
                #{CREW_DEST_PREFIX}/etc/xml/catalog &&
            xmlcatalog --noout --add 'delegatePublic' \
                '-//OASIS//DTD DocBook XML' \
                'file://#{CREW_PREFIX}/etc/xml/docbook' \
                #{CREW_DEST_PREFIX}/etc/xml/catalog &&
            xmlcatalog --noout --add 'delegateSystem' \
                'http://www.oasis-open.org/docbook/' \
                'file://#{CREW_PREFIX}/etc/xml/docbook' \
                #{CREW_DEST_PREFIX}/etc/xml/catalog &&
            xmlcatalog --noout --add 'delegateURI' \
                'http://www.oasis-open.org/docbook/' \
                'file://#{CREW_PREFIX}/etc/xml/docbook' \
                #{CREW_DEST_PREFIX}/etc/xml/catalog"
  end
end
