require 'package'

class Libcdio < Package
  description 'The GNU Compact Disc Input and Control library (libcdio) contains a library for CD-ROM and CD image access.'
  homepage 'http://www.gnu.org/software/libcdio/'
  version '2.1.0'
  compatibility 'all'
  license 'GPL-3'
  source_url 'https://ftpmirror.gnu.org/libcdio/libcdio-2.1.0.tar.bz2'
  source_sha256 '8550e9589dbd594bfac93b81ecf129b1dc9d0d51e90f9696f1b2f9b2af32712b'

  binary_url ({
     aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdio/2.1.0_armv7l/libcdio-2.1.0-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdio/2.1.0_armv7l/libcdio-2.1.0-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdio/2.1.0_i686/libcdio-2.1.0-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcdio/2.1.0_x86_64/libcdio-2.1.0-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
     aarch64: 'd501f42889d4d997b535180436445b914dd5646991a24b8bfbce0bab3233a5a0',
      armv7l: 'd501f42889d4d997b535180436445b914dd5646991a24b8bfbce0bab3233a5a0',
        i686: '023e53fb398b4c9429ff136aefb6b9c5341e4ff4bb0b7eb78072d1a141141d16',
      x86_64: 'ba61ed6f31f29fe3d477004d36d2b119f1d67db1d084109a96dff59f98b23bd1',
  })

  depends_on 'libcddb'

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --without-cdda-player \
              --enable-cxx \
              --disable-cpp-progs \
              --disable-example-progs"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
