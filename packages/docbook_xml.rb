require 'package'

# from LFS: http://www.linuxfromscratch.org/blfs/view/cvs/pst/docbook.html

class Docbook_xml < Package
  description 'document type definitions for verification of XML data files against the DocBook rule set'
  homepage 'http://www.docbook.org'
  version '4.3-1'
  source_url 'http://www.docbook.org/xml/4.3/docbook-xml-4.3.zip'
  source_sha256 '23068a94ea6fd484b004c5a73ec36a66aa47ea8f0d6b62cc1695931f5c143464'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml-4.3-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml-4.3-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml-4.3-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml-4.3-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd3008b147f80217982def39e17e04ab9dd32774932322685ae54e5310c70787b',
     armv7l: 'd3008b147f80217982def39e17e04ab9dd32774932322685ae54e5310c70787b',
       i686: '2650849c66d4838eb91c679dcd18792583e848a11073b8f60fdc2f5c9f81a7dd',
     x86_64: '2479e13c8b04434b51a07a96d8500a753042e08ed68dac8b692a267b44372001',
  })

  depends_on 'docbook'
  depends_on 'sgml_common'

  def self.install

    xml_version = '4.3'
    xml_dtd = "xml-dtd-#{xml_version}"

    system "install -v -d -m755 #{CREW_DEST_PREFIX}/share/xml/docbook/#{xml_dtd}"
    system "install -v -d -m755 #{CREW_DEST_PREFIX}/etc/xml"
    system "cp -rpa . #{CREW_DEST_PREFIX}/share/xml/docbook/#{xml_dtd}/"
    system "rm -f #{CREW_PREFIX}/etc/xml/docbook && \
                xmlcatalog --noout --create #{CREW_DEST_PREFIX}/etc/xml/docbook && \
            xmlcatalog --noout --add 'public' \
                '-//OASIS//DTD DocBook XML V#{xml_version}//EN' \
                'http://www.oasis-open.org/docbook/xml/#{xml_version}/docbookx.dtd' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//DTD DocBook XML CALS Table Model V#{xml_version}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/calstblx.dtd' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//DTD XML Exchange Table Model 19990315//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/soextblx.dtd' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ELEMENTS DocBook XML Information Pool V#{xml_version}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbpoolx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ELEMENTS DocBook XML Document Hierarchy V#{xml_version}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbhierx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ELEMENTS DocBook XML HTML Tables V#{xml_version}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/htmltblx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ENTITIES DocBook XML Notations V#{xml_version}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbnotnx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ENTITIES DocBook XML Character Entities V#{xml_version}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbcentx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ENTITIES DocBook XML Additional General Entities V#{xml_version}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbgenent.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'rewriteSystem' \
                'http://www.oasis-open.org/docbook/xml/#{xml_version}' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook &&
            xmlcatalog --noout --add 'rewriteURI' \
                'http://www.oasis-open.org/docbook/xml/#{xml_version}' \
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
