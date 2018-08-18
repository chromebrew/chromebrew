require 'package'

# from LFS: http://www.linuxfromscratch.org/blfs/view/cvs/pst/docbook-xsl.html

class Docbook_xsl < Package
  description 'The DocBook XSL Stylesheets package contains XSL stylesheets. These are useful for performing transformations on XML DocBook files.'
  homepage 'https://github.com/docbook/xslt10-stylesheets'
  version '1.79.1-1'
  source_url 'http://downloads.sourceforge.net/docbook/docbook-xsl-1.79.1.tar.bz2'
  source_sha256 '725f452e12b296956e8bfb876ccece71eeecdd14b94f667f3ed9091761a4a968'

  binary_url ({
  # Please do not create binaries for this package, breaks gtk_doc.
  })
  binary_sha256 ({
  })

  depends_on 'docbook_xml'

  def self.build
  end

  def self.install
    system "install -v -m755 -d #{CREW_DEST_PREFIX}/share/xml/docbook/xsl-stylesheets-1.79.1 &&
            cp -v -R . \
                #{CREW_DEST_PREFIX}/share/xml/docbook/xsl-stylesheets-1.79.1/"
    system "install -v -m644 -D README \
                                #{CREW_DEST_PREFIX}/share/doc/docbook-xsl-1.79.1/README.txt &&
            install -v -m644    RELEASE-NOTES* NEWS* \
                                #{CREW_DEST_PREFIX}/share/doc/docbook-xsl-1.79.1"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/xml"
    system "mv #{CREW_PREFIX}/etc/xml/catalog #{CREW_DEST_PREFIX}/etc/xml/"
    system "mv #{CREW_PREFIX}/etc/xml/docbook #{CREW_DEST_PREFIX}/etc/xml/"
    system "xmlcatalog --noout --add 'rewriteSystem' \
                       'http://docbook.sourceforge.net/release/xsl/1.79.1' \
                       '#{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-1.79.1' \
                #{CREW_DEST_PREFIX}/etc/xml/catalog &&
            
            xmlcatalog --noout --add 'rewriteURI' \
                       'http://docbook.sourceforge.net/release/xsl/1.79.1' \
                       '#{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-1.79.1' \
                #{CREW_DEST_PREFIX}/etc/xml/catalog &&
            
            xmlcatalog --noout --add 'rewriteSystem' \
                       'http://docbook.sourceforge.net/release/xsl/current' \
                       '#{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-1.79.1' \
                #{CREW_DEST_PREFIX}/etc/xml/catalog &&
            
            xmlcatalog --noout --add 'rewriteURI' \
                       'http://docbook.sourceforge.net/release/xsl/current' \
                       '#{CREW_PREFIX}/share/xml/docbook/xsl-stylesheets-1.79.1' \
                #{CREW_DEST_PREFIX}/etc/xml/catalog"
  end
end
