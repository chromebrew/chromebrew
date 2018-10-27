require 'package'

class Libav < Package
  description 'Libav provides cross-platform tools and libraries to convert, manipulate and stream a wide range of multimedia formats and protocols.'
  homepage 'https://www.libav.org/'
  version '12.3'
  source_url 'https://libav.org/releases/libav-12.3.tar.xz'
  source_sha256 '6893cdbd7bc4b62f5d8fd6593c8e0a62babb53e323fbc7124db3658d04ab443b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libav-12.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libav-12.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libav-12.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libav-12.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '31dda6c353eab2c8a9671fc1b22634f4dcc7fe8717fdbe9ec4581909f890fe1f',
     armv7l: '31dda6c353eab2c8a9671fc1b22634f4dcc7fe8717fdbe9ec4581909f890fe1f',
       i686: '23af5d635117763e3a73c952277bb92f80f968605419fdc0e7d5fee6bfe91f52',
     x86_64: 'e2ecf0997285a170d1d4b36d71c337c2605ec378064e94e306884f8d0c7cd2f3',
  })

  depends_on 'nasm'

  def self.build
    system "TMPDIR=#{CREW_PREFIX}/tmp \
           ./configure \
           --prefix=#{CREW_PREFIX} \
           --libdir=#{CREW_LIB_PREFIX} \
           --disable-static \
           --enable-shared"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
