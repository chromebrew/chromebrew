require 'package'

class Docbook_xml45 < Package
  description 'Version 4.5 -document type definitions for verification of XML data files against the DocBook rule set'
  compatibility 'all'
  homepage 'http://www.docbook.org'
  version '4.5'
  source_url 'http://www.oasis-open.org/docbook/xml/4.5/docbook-xml-4.5.zip'
  source_sha256 '4e4e037a2b83c98c6c94818390d4bdd3f6e10f6ec62dd79188594e26190dc7b4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml45-4.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml45-4.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml45-4.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xml45-4.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b328c89d8af6d6230a1d6e336601fa85f78486e28e9e4afdc085c38b94196857',
     armv7l: 'b328c89d8af6d6230a1d6e336601fa85f78486e28e9e4afdc085c38b94196857',
       i686: 'a79e4186e7f8bbe0f9d09cf8f7ad2116c4f3a07f654c968b303b0f307c0bb439',
     x86_64: 'a6330711188580cae005ed58e79b7c4eb39532f20cbd8e847d7ba4299b32533f',
  })

  depends_on 'docbook_xml51'
  depends_on 'docbook_xsl'

  def self.prebuild
    system "cat << EOF > ./remove_add.sh
sed -i -e 's,<!-- .* -->,,g' #{CREW_PREFIX}/etc/xml/catalog.xml
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook.xml remove public '-//OASIS//DTD DocBook XML V4.5//EN'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/docbook.xml add public '-//OASIS//DTD DocBook XML V4.5//EN' 'file://#{CREW_PREFIX}/share/xml/docbook/4.5/catalog.xml'
EOF"
    system 'bash ./remove_add.sh'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/xml/docbook/#{version}/"
  end
end

