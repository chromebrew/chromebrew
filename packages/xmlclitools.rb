require 'package'

class Xmlclitools < Package
  description 'xmlclitools provides four command-line tools for searching, modifying, and formating XML data. The tools are designed to work in conjunction with standard *nix utilities such as grep, sort, and shell scripts.'
  homepage 'http://freecode.com/projects/xmlclitools'
  version '1.61-1'
  compatibility 'all'
  source_url 'ftp://ftp.nstu.ru/pub/sources/langs/xml/xmlclitools-1.61.tar.gz'
  source_sha256 '262ce2f119a278ee2f965722f4d23b6b67f8baaa594858b9a0124849726e5a63'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xmlclitools-1.61-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xmlclitools-1.61-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xmlclitools-1.61-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xmlclitools-1.61-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'e22665bdf25bbce519a68103f4021ee803006368bbea85f9106b5a6dc8229dbf',
     armv7l: 'e22665bdf25bbce519a68103f4021ee803006368bbea85f9106b5a6dc8229dbf',
       i686: '6ebfd4ffa8c126a876bd8259b7684640cd4536d284cac275b036fa66e6091d21',
     x86_64: 'eb02a6633241f4bf4584f212d5bb693b3e22fa7e938f4885a8d1890d109cad7d',
  })

  depends_on 'glib'
  depends_on 'pcre'
  depends_on 'libxml2'

  def self.patch
    system "sed -i 's,/usr/local,#{CREW_DEST_PREFIX},g' Makefile"
    system "sed -i 's,/usr/include,#{CREW_PREFIX}/include,g' Makefile"
    system "sed -i 's,/usr/lib,#{CREW_LIB_PREFIX},g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
