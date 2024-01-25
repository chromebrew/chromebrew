require 'package'

class Libdv < Package
  description 'The Quasar DV codec libdv is a software codec for DV video'
  homepage 'http://libdv.sourceforge.net/'
  version '1.0.0-1'
  license 'libdv'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/libdv/libdv-1.0.0.tar.gz'
  source_sha256 'a305734033a9c25541a59e8dd1c254409953269ea7c710c39e540bd8853389ba'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '74afbcfd3c2ae2209ca1d65b08590504f467fa319a686363e58f5f47c3dbec60',
     armv7l: '74afbcfd3c2ae2209ca1d65b08590504f467fa319a686363e58f5f47c3dbec60',
       i686: '28bde5081c65a611ca446c0ed3bcd66ab7dcf296511ba4b617c64a129019ca48',
     x86_64: '626912b6bf0fd3cbc315b913b5b80b0d707573c9a44e69680b6fb53213b14cfc'
  })

  depends_on 'popt'
  depends_on 'libxv'

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
    ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
