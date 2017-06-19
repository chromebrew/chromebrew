require 'package'

class Moreutils < Package
  description 'moreutils is a growing collection of the unix tools that nobody thought to write long ago when unix was young.'
  homepage 'https://joeyh.name/code/moreutils/'
  version '0.60'
  source_url 'http://http.debian.net/debian/pool/main/m/moreutils/moreutils_0.60.orig.tar.xz'
  source_sha1 '3af60490f763ece48b2fcba968903673c3e63495'

  depends_on 'docbook'
  depends_on 'libxslt'

  def self.build
    system "sed -i 's,PREFIX?=/usr,PREFIX?=/usr/local,' Makefile"
    system "sed -i 's,DOCBOOKXSL?=/usr/share/xml/docbook/stylesheet/docbook-xsl,DOCBOOKXSL?=/usr/local/docbook,' Makefile"
    system "sed -i 's,share/man,man,g' Makefile"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
