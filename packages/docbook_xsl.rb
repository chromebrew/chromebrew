require 'package'

# Note: due to issues with catalog.xml caused by 1.79.2 not existing on the sourceforge server we have reverted to 1.79.1
# from Void Linux https://git.io/JUZ02

class Docbook_xsl < Package
  description 'The DocBook XSL Stylesheets package contains XSL stylesheets. These are useful for performing transformations on XML DocBook files.'
  compatibility 'all'
  homepage 'https://github.com/docbook/xslt10-stylesheets'
  version '1.79.1-1'
  source_url 'https://downloads.sourceforge.net/sourceforge/docbook/docbook-xsl-1.79.1.tar.bz2'
  source_sha256 '725f452e12b296956e8bfb876ccece71eeecdd14b94f667f3ed9091761a4a968'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xsl-1.79.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xsl-1.79.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xsl-1.79.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xsl-1.79.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c13af861d61b6fa028f9226b7bf162d16806dde5defb6de159c2783f07823dd5',
     armv7l: 'c13af861d61b6fa028f9226b7bf162d16806dde5defb6de159c2783f07823dd5',
       i686: '185c090525ab3928fd6403fd3704bb21e2ebfbec6bdb78d802a253a25df3b570',
     x86_64: '49941481dcefe3b2c570ee916e478c33c25f36694d5d028356defcaa3401f882',
  })


  depends_on 'docbook_xml'

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
    system 'cat << \'EOF\' > ./catalog.xml
<?xml version="1.0" encoding="utf-8"?>
<catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog">
  <!-- XML Catalog file for DocBook XSL Stylesheets vsnapshot_9899 -->
  <rewriteURI uriStartString="http://docbook.sourceforge.net/release/xsl/current/" rewritePrefix="./"/>
  <rewriteSystem systemIdStartString="http://docbook.sourceforge.net/release/xsl/current/" rewritePrefix="./"/>
  <rewriteURI uriStartString="http://docbook.sourceforge.net/release/xsl/snapshot_9899/" rewritePrefix="./"/>
  <rewriteSystem systemIdStartString="http://docbook.sourceforge.net/release/xsl/snapshot_9899/" rewritePrefix="./"/>
  <delegatePublic publicIdStartString="-//OASIS//ENTITIES DocBook XML" catalog="file:///usr/local/etc/xml/docbook"/>
  <delegatePublic publicIdStartString="-//OASIS//DTD DocBook XML" catalog="file:///usr/local/etc/xml/docbook"/>
  <delegateSystem systemIdStartString="http://www.oasis-open.org/docbook/" catalog="file:///usr/local/etc/xml/docbook"/>
  <delegateURI uriStartString="http://www.oasis-open.org/docbook/" catalog="file:///usr/local/etc/xml/docbook"/>
</catalog>
EOF'
    system "install -v -Dm644 catalog.xml #{CREW_DEST_PREFIX}/etc/xml/catalog.xml"
  end
end
