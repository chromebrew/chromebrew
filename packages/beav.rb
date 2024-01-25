require 'package'

class Beav < Package
  description 'BEAV (Binary Editor And Viewer), is a full featured binary file editor.'
  homepage 'https://packages.debian.org/sid/beav'
  version '1.40-18-1'
  license 'GPL-1+'
  compatibility 'all'
  source_url 'https://httpredir.debian.org/debian/pool/main/b/beav/beav_1.40.orig.tar.gz'
  source_sha256 '7ad905e4124bf105ca0e213d8212bed231559825ac11588794b9be7a91399ddc'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '5cc00778439b0fc1a73085ce7d0b32c9c755720bcd0d74a21fa8c317280e25f1',
     armv7l: '5cc00778439b0fc1a73085ce7d0b32c9c755720bcd0d74a21fa8c317280e25f1',
       i686: '3daab25a1384ddc87a83967b265cb19e905e474a24fa3eded9a32d45df57f2ef',
     x86_64: 'a7c7a9e5a3399af8bcab01bb927855415370d6f6f3f7374633c5592010e0a089'
  })

  def self.patch
    system 'curl -#L https://httpredir.debian.org/debian/pool/main/b/beav/beav_1.40-18.diff.gz | gunzip >> beav_1.40-18.diff'
    abort 'Checksum mismatch. :/ Try again.'.lightred unless Digest::SHA256.hexdigest(File.read('beav_1.40-18.diff')) == '5139aa0bdc9424b7ad8197070e1902d8225ee78e2091d02a493422cd91fe5973'
    system 'patch -Np1 -i beav_1.40-18.diff'
    system "sed -i 's:-lncurses:-ltinfow:g' Makefile"
    system "sed -i '12d' basic.c"
    system "sed -i '13d' file.c"
    system "sed -i '76d' random.c"
    system "sed -i '11d' symbol.c"
    system "sed -i 's:#include <term.h>:#include <ncursesw/term.h>:' tcap.c"
    system "sed -i 's,-g -DUNIX -Wall,-g -DUNIX -Wall -flto=auto,g' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1/"
    FileUtils.install 'beav', "#{CREW_DEST_PREFIX}/bin/beav", mode: 0o755
    FileUtils.install 'beav.1', "#{CREW_DEST_MAN_PREFIX}/man1/beav.1", mode: 0o644
  end
end
