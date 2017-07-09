require 'package'

class Libtheora < Package
  description 'Theora is a free and open video compression format from the Xiph.org Foundation.'
  homepage 'https://theora.org/'
  version '1.1.1'
  source_url 'http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2'
  source_sha256 'b6ae1ee2fa3d42ac489287d3ec34c5885730b1296f0801ae577a35193d3affbc'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libtheora-1.1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/libtheora-1.1.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/libtheora-1.1.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/libtheora-1.1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6173abc863fd778b24bee2ee2ff46a091a0d2fb9e378fe612a978871e870d1c6',
     armv7l: '6173abc863fd778b24bee2ee2ff46a091a0d2fb9e378fe612a978871e870d1c6',
       i686: '625858cd100848dfa51c13db95bc32a41359ceb6e63e91e127597a90a88f6be9',
     x86_64: '5ac663dd01f43db8cfd7b8b108cc1cc437e6b00171cb2b752e5c5ec4efee031b',
  })

  depends_on 'libvorbis'
  depends_on 'libsdl2'

  def self.build
    system "sed -i 's/png_sizeof/sizeof/g' ./examples/png2theora.c"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
