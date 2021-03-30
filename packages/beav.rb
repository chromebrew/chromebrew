require 'package'

class Beav < Package
  description 'BEAV (Binary Editor And Viewer), is a full featured binary file editor.'
  homepage 'https://packages.debian.org/sid/beav'
  version '1.40-18-1'
  license 'GPL-1+'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/b/beav/beav_1.40.orig.tar.gz'
  source_sha256 '7ad905e4124bf105ca0e213d8212bed231559825ac11588794b9be7a91399ddc'

  def self.patch
    system "curl -#L https://httpredir.debian.org/debian/pool/main/b/beav/beav_1.40-18.diff.gz | gunzip >> beav_1.40-18.diff"
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest( File.read('beav_1.40-18.diff') ) == '5139aa0bdc9424b7ad8197070e1902d8225ee78e2091d02a493422cd91fe5973'
    system "patch -Np1 -i beav_1.40-18.diff"
    system "sed -i 's:-lncurses:-ltinfow:g' Makefile"
    system "sed -i '12d' basic.c"
    system "sed -i '13d' file.c"
    system "sed -i '76d' random.c"
    system "sed -i '11d' symbol.c"
    system "sed -i 's:#include <term.h>:#include <ncursesw/term.h>:' tcap.c"
  end

  def self.build
    system 'make'
  end

  def self.install
    system "install -Dm 755 beav #{CREW_DEST_PREFIX}/bin/beav"
    system "install -Dm 755 beav.1 #{CREW_DEST_MAN_PREFIX}/man1/beav.1"
  end
end
