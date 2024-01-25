require 'package'

class Libcdio < Package
  description 'The GNU Compact Disc Input and Control library (libcdio) contains a library for CD-ROM and CD image access.'
  homepage 'http://www.gnu.org/software/libcdio/'
  version '2.1.0-1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libcdio/libcdio-2.1.0.tar.bz2'
  source_sha256 '8550e9589dbd594bfac93b81ecf129b1dc9d0d51e90f9696f1b2f9b2af32712b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '037febd86116cf613cb862ed3cdcfa1d1e3eb4c927f829a4787c8fc4b6f6ae9f',
     armv7l: '037febd86116cf613cb862ed3cdcfa1d1e3eb4c927f829a4787c8fc4b6f6ae9f',
       i686: 'cea93fa26bf23e425f8a1d4f14347c6a21c9c5e02887e6d8bf2761126ad022d2',
     x86_64: '1988c60ace1972669716ef55db1445708b1692cd44692edc269fbb759fbd1f6e'
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
