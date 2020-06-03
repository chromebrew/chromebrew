require 'package'

class Nedit < Package
  description 'A fast, compact Motif/X11 plain text editor, for most popular Unix systems.'
  homepage 'https://sourceforge.net/projects/nedit/'
  version '5.7'
  source_url 'https://downloads.sourceforge.net/project/nedit/nedit-source/nedit-5.7-src.tar.gz'
  source_sha256 'add9ac79ff973528ad36c86858238bac4f59896c27dbf285cbe6a4d425fca17a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nedit-5.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nedit-5.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nedit-5.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nedit-5.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4fba5943ef167821c201b21a09dece98b6d81cbcb79527c64e95000f4479c3d8',
     armv7l: '4fba5943ef167821c201b21a09dece98b6d81cbcb79527c64e95000f4479c3d8',
       i686: 'a51c662322d42a5a9a040f0c5eda0535c1f03fbc3bb15cb4652a5c7fb5ede8b2',
     x86_64: 'c2db0f40ee914ab92f65814953542ec9e5634415ea155076cf9e67f50e9428ed',
  })

  depends_on 'motif'

  def self.patch
    system "sed -i 's/\$@/linux/g' Makefile"
  end

  def self.build
    system 'make', 'linux'
    Dir.chdir 'doc' do
      system 'make', 'man'
    end
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system "install -Dm755 ./source/nc #{CREW_DEST_PREFIX}/bin/nc"
    system "install -Dm755 ./source/nedit #{CREW_DEST_PREFIX}/bin/nedit"
    system "install -Dm644 ./doc/nc.man #{CREW_DEST_MAN_PREFIX}/man1/nc.1"
    system "install -Dm644 ./doc/nedit.man #{CREW_DEST_MAN_PREFIX}/man1/nedit.1"
  end
end

