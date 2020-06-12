require 'package'

class Libsamplerate < Package
  description 'Secret Rabbit Code (aka libsamplerate) is a Sample Rate Converter for audio.'
  homepage 'http://www.mega-nerd.com/libsamplerate/'
  version '0.1.9'
  compatibility 'all'
  source_url 'http://www.mega-nerd.com/libsamplerate/libsamplerate-0.1.9.tar.gz'
  source_sha256 '0a7eb168e2f21353fb6d84da152e4512126f7dc48ccb0be80578c565413444c1'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libsamplerate-0.1.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libsamplerate-0.1.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libsamplerate-0.1.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libsamplerate-0.1.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cae5af051ec2d36af1e8c1acfc8fc8fd3b7d81d22492a6f2226561c78733775f',
     armv7l: 'cae5af051ec2d36af1e8c1acfc8fc8fd3b7d81d22492a6f2226561c78733775f',
       i686: '4f848d40fd487d9241008719b31df0dbf5257db5b9741977b5811fa691e9304e',
     x86_64: '57c63e7f734cd31d645ec93582488f1c6fb1a14de3c8ad6b1d0cf9c9464e48bc',
  })

  depends_on 'alsa_lib'
  depends_on 'fftw'
  depends_on 'libsndfile'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
