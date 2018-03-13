require 'package'

class Libtheora < Package
  description 'Theora is a free and open video compression format from the Xiph.org Foundation.'
  homepage 'https://theora.org/'
  version '1.1.1-0'
  source_url 'https://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2'
  source_sha256 'b6ae1ee2fa3d42ac489287d3ec34c5885730b1296f0801ae577a35193d3affbc'


  depends_on 'libvorbis'
  depends_on 'libsdl2'

  def self.build
    system "sed -i 's/png_sizeof/sizeof/g' ./examples/png2theora.c"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
