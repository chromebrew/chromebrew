require 'package'

# from LFS: http://www.linuxfromscratch.org/blfs/view/cvs/pst/docbook-xsl.html

class Docbook_xsl < Package
  description 'The DocBook XSL Stylesheets package contains XSL stylesheets. These are useful for performing transformations on XML DocBook files.'
  homepage 'https://github.com/docbook/xslt10-stylesheets'
  version '1.79.2-1'
  source_url 'https://github.com/docbook/xslt10-stylesheets/releases/download/release/1.79.2/docbook-xsl-1.79.2.tar.bz2'
  source_sha256 '316524ea444e53208a2fb90eeb676af755da96e1417835ba5f5eb719c81fa371'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'docbook_xml'

  def self.patch
    system 'wget http://www.linuxfromscratch.org/patches/blfs/svn/docbook-xsl-nons-1.79.2-stack_fix-1.patch'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('docbook-xsl-nons-1.79.2-stack_fix-1.patch') ) == 'a92c39715c54949ba9369add1809527b8f155b7e2a2b2e30cb4b39ee715f2e30'
    system 'patch -Np1 -i docbook-xsl-nons-1.79.2-stack_fix-1.patch'
  end

  def self.install

    xsl_version = '1.79.2'
    xsl_stylesheets = "xsl-stylesheets-#{xsl_version}"
    docbook_xsl = "docbook-xsl-#{xsl_version}"

    system "install -v -m755 -d #{CREW_DEST_PREFIX}/share/xml/#{xsl_stylesheets} &&
            cp -v -R . #{CREW_DEST_PREFIX}/share/xml/#{xsl_stylesheets}/"
    system "install -v -m644 -D README #{CREW_DEST_PREFIX}/share/doc/#{docbook_xsl}/README.txt &&
            install -v -m644 RELEASE-NOTES* NEWS* #{CREW_DEST_PREFIX}/share/doc/#{docbook_xsl}"
    system "xmlcatalog --noout --add 'rewriteSystem' \
                       'http://docbook.sourceforge.net/release/xsl/#{xsl_version}' \
                       '#{CREW_PREFIX}/share/xml/docbook/#{xsl_stylesheets}' \
                #{CREW_PREFIX}/etc/xml/catalog &&
            xmlcatalog --noout --add 'rewriteURI' \
                       'http://docbook.sourceforge.net/release/xsl/#{xsl_version}' \
                       '#{CREW_PREFIX}/share/xml/docbook/#{xsl_stylesheets}' \
                #{CREW_PREFIX}/etc/xml/catalog &&
            xmlcatalog --noout --add 'rewriteSystem' \
                       'http://docbook.sourceforge.net/release/xsl/current' \
                       '#{CREW_PREFIX}/share/xml/docbook/#{xsl_stylesheets}' \
                #{CREW_PREFIX}/etc/xml/catalog &&
            xmlcatalog --noout --add 'rewriteURI' \
                       'http://docbook.sourceforge.net/release/xsl/current' \
                       '#{CREW_PREFIX}/share/xml/docbook/#{xsl_stylesheets}' \
                #{CREW_PREFIX}/etc/xml/catalog"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/xml"
    system "mv #{CREW_PREFIX}/etc/xml/catalog #{CREW_DEST_PREFIX}/etc/xml/"
  end
end
