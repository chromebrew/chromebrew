require 'package'

# Note: due to issues with catalog.xml caused by 1.79.2 not existing on the sourceforge server we have reverted to 1.79.1
# from Void Linux https://git.io/JUZ02

class Docbook_xsl < Package
  description 'The DocBook XSL Stylesheets package contains XSL stylesheets. These are useful for performing transformations on XML DocBook files.'
  compatibility 'all'
  homepage 'https://github.com/docbook/xslt10-stylesheets'
  version '1.79.1-2'
  source_url 'https://downloads.sourceforge.net/sourceforge/docbook/docbook-xsl-1.79.1.tar.bz2'
  source_sha256 '725f452e12b296956e8bfb876ccece71eeecdd14b94f667f3ed9091761a4a968'

  depends_on 'docbook_xml51'
  depends_on 'xmlcatmgr'

  def self.patch
    system 'wget -O "non-recursive_string_subst.patch" "https://git.io/JUZ02"'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('non-recursive_string_subst.patch') ) == '1efc7c0a67d3c655f9e6df78aa6cec2583b4c94792bf5112925cd9b2086914fd'
    system 'patch -Np1 -i non-recursive_string_subst.patch ./lib/lib.xsl'
  end

  def self.install

    xsl_version = '1.79.1'
    xsl_stylesheets = "xsl-stylesheets-#{xsl_version}"
    docbook_xsl = "docbook-xsl-#{xsl_version}"

    system "install -v -m755 -d #{CREW_DEST_PREFIX}/share/xml/#{xsl_stylesheets} &&
            cp -v -R . #{CREW_DEST_PREFIX}/share/xml/#{xsl_stylesheets}/"
    system "install -v -m644 -D README #{CREW_DEST_PREFIX}/share/doc/#{docbook_xsl}/README.txt &&
            install -v -m644 RELEASE-NOTES* NEWS* #{CREW_DEST_PREFIX}/share/doc/#{docbook_xsl}"
    system "sed -i -e 's,<!-- .* -->,,g' #{CREW_PREFIX}/etc/xml/catalog.xml"
    system "cat << EOF > ./remove_add.sh
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/catalog.xml remove rewriteSystem 'http://docbook.sourceforge.net/release/xsl/snapshot_9899/'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/catalog.xml remove rewriteURI 'http://docbook.sourceforge.net/release/xsl/current/'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/catalog.xml remove rewriteURI 'http://docbook.sourceforge.net/release/xsl/snapshot_9899/'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/catalog.xml add rewriteSystem 'http://docbook.sourceforge.net/release/xsl/snapshot_9899/' './'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/catalog.xml add rewriteURI 'http://docbook.sourceforge.net/release/xsl/current/' './'
xmlcatmgr -c #{CREW_PREFIX}/etc/xml/catalog.xml add rewriteURI 'http://docbook.sourceforge.net/release/xsl/snapshot_9899/' './'
EOF"
    system "bash ./remove_add.sh"
  end
end

# NOTE: 