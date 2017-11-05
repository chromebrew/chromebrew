require 'package'

class Xmlclitools < Package
  description 'xmlclitools provides four command-line tools for searching, modifying, and formating XML data. The tools are designed to work in conjunction with standard *nix utilities such as grep, sort, and shell scripts.'
  homepage 'http://freecode.com/projects/xmlclitools'
  version '1.61-1'
  source_url 'ftp://ftp.nstu.ru/pub/sources/langs/xml/xmlclitools-1.61.tar.gz'
  source_sha256 '262ce2f119a278ee2f965722f4d23b6b67f8baaa594858b9a0124849726e5a63'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glib'
  depends_on 'pcre'
  depends_on 'libxml2'

  def self.preinstall
    system "sed -i 's,/usr/local,#{CREW_DEST_PREFIX},g' Makefile"
    system "sed -i 's,/usr/include,#{CREW_PREFIX}/include,g' Makefile"
    system "sed -i 's,/usr/lib,#{CREW_LIB_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
