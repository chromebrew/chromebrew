require 'package'

class Libtheora < Package
  description 'Theora is a free and open video compression format from the Xiph.org Foundation.'
  homepage 'https://theora.org/'
  version '1.1.1-0'
  compatibility 'all'
  source_url 'https://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2'
  source_sha256 'b6ae1ee2fa3d42ac489287d3ec34c5885730b1296f0801ae577a35193d3affbc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libtheora-1.1.1-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libtheora-1.1.1-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libtheora-1.1.1-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libtheora-1.1.1-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8737530ad3a7923d32b273258123f8c18d9f7c7ef13be95880e9b4e85d435cfb',
     armv7l: '8737530ad3a7923d32b273258123f8c18d9f7c7ef13be95880e9b4e85d435cfb',
       i686: '971dfa07b59b68f7c4861b2bbfd65f6b64a937c69b8fd42bf4fa4b1b567ee49f',
     x86_64: '281643b002a7da1589c01550d7a73ca0eed69d4bde2529b6c881bc8debd2bade',
  })

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
