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

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xsl-1.79.1-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xsl-1.79.1-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xsl-1.79.1-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/docbook_xsl-1.79.1-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd7a0dc1bcfb4a670ca50f70c34d479f887ef918317babaca146b412e2bbc4c44',
     armv7l: 'd7a0dc1bcfb4a670ca50f70c34d479f887ef918317babaca146b412e2bbc4c44',
       i686: '92b5c7a3b696123ec9c19b3686910176127fd4c23dcfe3f47ea305e17d393a17',
     x86_64: 'ac55be955bd36b0d7f6481bbc2e4a58bdff336fdc536d29156963bc4f5e3b949',
  })

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
    system "cat << EOF > ./remove_add.sh
sed -i -e 's,<!-- .* -->,,g' #{CREW_PREFIX}/etc/xml/catalog.xml
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
