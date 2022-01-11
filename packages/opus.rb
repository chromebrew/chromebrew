require 'package'

class Opus < Package
  description 'Opus is a totally open, royalty-free, highly versatile audio codec.'
  homepage 'https://opus-codec.org/'
  version '1.3.1'
  license 'BSD'
  compatibility 'all'
  source_url 'https://archive.mozilla.org/pub/opus/opus-1.3.1.tar.gz'
  source_sha256 '65b58e1e25b2a114157014736a3d9dfeaad8d41be1c8179866f144a2fb44ff9d'

  depends_on 'doxygen' => :build

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --enable-custom-modes"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
