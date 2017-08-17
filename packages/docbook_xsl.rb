require 'package'

# from LFS: http://www.linuxfromscratch.org/blfs/view/cvs/pst/docbook-xsl.html

class Docbook_xsl < Package
  description 'The DocBook XSL Stylesheets package contains XSL stylesheets. These are useful for performing transformations on XML DocBook files.'
  homepage 'https://github.com/docbook/xslt10-stylesheets'
  version '1.79.1'
  source_url 'http://downloads.sourceforge.net/docbook/docbook-xsl-1.79.1.tar.bz2'
  source_sha256 '725f452e12b296956e8bfb876ccece71eeecdd14b94f667f3ed9091761a4a968'

  depends_on 'unzip'
  depends_on 'libxml2'
  depends_on 'libxslt'
  depends_on 'docbook_xml'
  depends_on 'docbook'

  def self.build
  end

  def self.install
    system "install -v -m755 -d #{CREW_DEST_DIR}/usr/local/share/xml/docbook/xsl-stylesheets-1.79.1 &&
            cp -v -R VERSION assembly common eclipse epub epub3 extensions fo        \
                     highlighting html htmlhelp images javahelp lib manpages params  \
                     profiling roundtrip slides template tests tools webhelp website \
                     xhtml xhtml-1_1 xhtml5                                          \
                #{CREW_DEST_DIR}/usr/local/share/xml/docbook/xsl-stylesheets-1.79.1 &&
            
            ln -s VERSION #{CREW_DEST_DIR}/usr/local/share/xml/docbook/xsl-stylesheets-1.79.1/VERSION.xsl &&
            
            install -v -m644 -D README \
                                #{CREW_DEST_DIR}/usr/local/share/doc/docbook-xsl-1.79.1/README.txt &&
            install -v -m644    RELEASE-NOTES* NEWS* \
                                #{CREW_DEST_DIR}/usr/local/share/doc/docbook-xsl-1.79.1"
    
    system "xmlcatalog --noout --add 'rewriteSystem' \
                       'http://docbook.sourceforge.net/release/xsl/1.79.1' \
                       '#{CREW_DEST_DIR}/usr/local/share/xml/docbook/xsl-stylesheets-1.79.1' \
                /usr/local/etc/xml/catalog &&
            
            xmlcatalog --noout --add 'rewriteURI' \
                       'http://docbook.sourceforge.net/release/xsl/1.79.1' \
                       '#{CREW_DEST_DIR}/usr/local/share/xml/docbook/xsl-stylesheets-1.79.1' \
                /usr/local/etc/xml/catalog &&
            
            xmlcatalog --noout --add 'rewriteSystem' \
                       'http://docbook.sourceforge.net/release/xsl/current' \
                       '#{CREW_DEST_DIR}/usr/local/share/xml/docbook/xsl-stylesheets-1.79.1' \
                /usr/local/etc/xml/catalog &&
            
            xmlcatalog --noout --add 'rewriteURI' \
                       'http://docbook.sourceforge.net/release/xsl/current' \
                       '#{CREW_DEST_DIR}/usr/local/share/xml/docbook/xsl-stylesheets-1.79.1' \
                /usr/local/etc/xml/catalog"

  end
end
