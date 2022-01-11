require 'package'

class Libcdio < Package
  description 'The GNU Compact Disc Input and Control library (libcdio) contains a library for CD-ROM and CD image access.'
  homepage 'http://www.gnu.org/software/libcdio/'
  version '2.1.0'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libcdio/libcdio-2.1.0.tar.bz2'
  source_sha256 '8550e9589dbd594bfac93b81ecf129b1dc9d0d51e90f9696f1b2f9b2af32712b'

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
