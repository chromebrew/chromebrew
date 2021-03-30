require 'package'

class Beav < Package
  description 'BEAV (Binary Editor And Viewer), is a full featured binary file editor.'
  homepage 'https://packages.debian.org/sid/beav'
  version '1.40-18-1'
  license 'GPL-1+'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/b/beav/beav_1.40.orig.tar.gz'
  source_sha256 '7ad905e4124bf105ca0e213d8212bed231559825ac11588794b9be7a91399ddc'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/beav-1.40-18-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/beav-1.40-18-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/beav-1.40-18-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/beav-1.40-18-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fac8efa93e9de76a5911f697643196d5aa02ec1df1865679c1e9eab57bef2aa0',
     armv7l: 'fac8efa93e9de76a5911f697643196d5aa02ec1df1865679c1e9eab57bef2aa0',
       i686: '37929bc862c17eecb5cbcdffd38c5e14cf46c88f871585ede0990a89b62acc93',
     x86_64: 'a206053a68383e261ba61e11fc7aded3f42d2dc1b8a432da4fb9ac479a250511'
  })

  def self.patch
    system 'curl -#L https://httpredir.debian.org/debian/pool/main/b/beav/beav_1.40-18.diff.gz | gunzip >> beav_1.40-18.diff'
    unless Digest::SHA256.hexdigest(File.read('beav_1.40-18.diff')) == '5139aa0bdc9424b7ad8197070e1902d8225ee78e2091d02a493422cd91fe5973'
      abort 'Checksum mismatch. :/ Try again.'.lightred
    end
    system 'patch -Np1 -i beav_1.40-18.diff'
    system "sed -i 's:-lncurses:-ltinfow:g' Makefile"
    system "sed -i '12d' basic.c"
    system "sed -i '13d' file.c"
    system "sed -i '76d' random.c"
    system "sed -i '11d' symbol.c"
    system "sed -i 's:#include <term.h>:#include <ncursesw/term.h>:' tcap.c"
    system "sed -i 's,-g -DUNIX -Wall,-g -DUNIX -Wall -flto,g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.install 'beav', "#{CREW_DEST_PREFIX}/bin/beav", mode: 0755
    FileUtils.install 'beav.1' "#{CREW_DEST_MAN_PREFIX}/man1/beav.1", mode: 0755
  end
end
