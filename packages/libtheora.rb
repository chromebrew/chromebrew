require 'package'

class Libtheora < Package
  description 'Theora is a free and open video compression format from the Xiph.org Foundation.'
  homepage 'https://theora.org/'
  version '1.1.1-0'
  license 'BSD'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2'
  source_sha256 'b6ae1ee2fa3d42ac489287d3ec34c5885730b1296f0801ae577a35193d3affbc'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '8737530ad3a7923d32b273258123f8c18d9f7c7ef13be95880e9b4e85d435cfb',
     armv7l: '8737530ad3a7923d32b273258123f8c18d9f7c7ef13be95880e9b4e85d435cfb',
     x86_64: '281643b002a7da1589c01550d7a73ca0eed69d4bde2529b6c881bc8debd2bade'
  })

  depends_on 'libvorbis'
  depends_on 'libsdl2'

  def self.build
    system "sed -i 's/png_sizeof/sizeof/g' ./examples/png2theora.c"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
