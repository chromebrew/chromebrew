require 'package'

# from LFS: http://www.linuxfromscratch.org/blfs/view/cvs/pst/docbook.html

class Docbook_xml51 < Package
  description 'Version 5.1 - document type definitions for verification of XML data files against the DocBook rule set'
  compatibility 'all'
  homepage 'http://www.docbook.org'
  version '5.1'
  source_url 'https://docbook.org/xml/5.1/docbook-v5.1-os.zip'
  source_sha256 'b3f3413654003c1e773360d7fc60ebb8abd0e8c9af8e7d6c4b55f124f34d1e7f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml51-5.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml51-5.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml51-5.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml51-5.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8bf41dbd91624c154972a4b0adf16ba0edbc77cdddf579baccd7877a8b9fddbf',
     armv7l: '8bf41dbd91624c154972a4b0adf16ba0edbc77cdddf579baccd7877a8b9fddbf',
       i686: '3512b6df3df4e420df0b265dd02dbfb76d6b7d4cbcdcdd18dfd54e0d03d869b3',
     x86_64: '718587a22a3fa9e91d8b974e5e02d4f21223d7699b7f4cae91faba1f7ea25358',
  })

  depends_on 'docbook'
  depends_on 'sgml_common'

  def self.install

    xml_version = '5.1'
    xml_dtd = "xml-dtd-#{xml_version}"

    system "install -v -d -m755 #{CREW_DEST_PREFIX}/share/xml/docbook/#{xml_dtd}"
    system "install -v -d -m755 #{CREW_DEST_PREFIX}/etc/xml"
    system "cp -rpa . #{CREW_DEST_PREFIX}/share/xml/docbook/#{xml_dtd}/"
    system "rm -f #{CREW_PREFIX}/etc/xml/docbook* && \
                xmlcatalog --noout --create #{CREW_DEST_PREFIX}/etc/xml/docbook.xml && \
            xmlcatalog --noout --add 'public' \
                '-//OASIS//DTD DocBook XML V#{xml_version}//EN' \
                'http://www.oasis-open.org/docbook/xml/#{xml_version}/docbookx.dtd' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook.xml &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//DTD DocBook XML CALS Table Model V#{xml_version}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/calstblx.dtd' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook.xml &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//DTD XML Exchange Table Model 19990315//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/soextblx.dtd' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook.xml &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ELEMENTS DocBook XML Information Pool V#{xml_version}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbpoolx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook.xml &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ELEMENTS DocBook XML Document Hierarchy V#{xml_version}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbhierx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook.xml &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ELEMENTS DocBook XML HTML Tables V#{xml_version}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/htmltblx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook.xml &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ENTITIES DocBook XML Notations V#{xml_version}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbnotnx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook.xml &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ENTITIES DocBook XML Character Entities V#{xml_version}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbcentx.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook.xml &&
            xmlcatalog --noout --add 'public' \
                '-//OASIS//ENTITIES DocBook XML Additional General Entities V#{xml_version}//EN' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}/dbgenent.mod' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook.xml &&
            xmlcatalog --noout --add 'rewriteSystem' \
                'http://www.oasis-open.org/docbook/xml/#{xml_version}' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook.xml &&
            xmlcatalog --noout --add 'rewriteURI' \
                'http://www.oasis-open.org/docbook/xml/#{xml_version}' \
                'file://#{CREW_PREFIX}/share/xml/docbook/#{xml_dtd}' \
                #{CREW_DEST_PREFIX}/etc/xml/docbook.xml"
    
    system "rm -f #{CREW_PREFIX}/etc/xml/catalog* && \
                xmlcatalog --noout --create #{CREW_DEST_PREFIX}/etc/xml/catalog.xml && \
            xmlcatalog --noout --add 'delegatePublic' \
                '-//OASIS//ENTITIES DocBook XML' \
                'file://#{CREW_PREFIX}/etc/xml/docbook.xml' \
                #{CREW_DEST_PREFIX}/etc/xml/catalog.xml &&
            xmlcatalog --noout --add 'delegatePublic' \
                '-//OASIS//DTD DocBook XML' \
                'file://#{CREW_PREFIX}/etc/xml/docbook.xml' \
                #{CREW_DEST_PREFIX}/etc/xml/catalog.xml &&
            xmlcatalog --noout --add 'delegateSystem' \
                'http://www.oasis-open.org/docbook/' \
                'file://#{CREW_PREFIX}/etc/xml/docbook.xml' \
                #{CREW_DEST_PREFIX}/etc/xml/catalog.xml &&
            xmlcatalog --noout --add 'delegateURI' \
                'http://www.oasis-open.org/docbook/' \
                'file://#{CREW_PREFIX}/etc/xml/docbook.xml' \
                #{CREW_DEST_PREFIX}/etc/xml/catalog.xml"
  end
end
