require 'package'

class Libtheora < Package
  description 'Theora is a free and open video compression format from the Xiph.org Foundation.'
  homepage 'https://theora.org/'
  version '1.1.1'
  source_url 'http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2'
  source_sha1 '8dcaa8e61cd86eb1244467c0b64b9ddac04ae262'

  depends_on 'libvorbis'
  depends_on 'libsdl'

  def self.build
    system "sed -i 's/png_sizeof/sizeof/g' ./examples/png2theora.c"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
