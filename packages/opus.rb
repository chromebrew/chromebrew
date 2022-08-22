require 'package'

class Opus < Package
  description 'Opus is a totally open, royalty-free, highly versatile audio codec.'
  homepage 'https://opus-codec.org/'
  version '1.3.1'
  compatibility 'all'
  license 'BSD'
  source_url 'https://archive.mozilla.org/pub/opus/opus-1.3.1.tar.gz'
  source_sha256 '65b58e1e25b2a114157014736a3d9dfeaad8d41be1c8179866f144a2fb44ff9d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opus/1.3.1_armv7l/opus-1.3.1-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opus/1.3.1_armv7l/opus-1.3.1-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opus/1.3.1_i686/opus-1.3.1-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/opus/1.3.1_x86_64/opus-1.3.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'ddf29b45d6a99e2e1a1c5dd87529978a6d4f922695425f504d3622090e6b033a',
      armv7l: 'ddf29b45d6a99e2e1a1c5dd87529978a6d4f922695425f504d3622090e6b033a',
        i686: '9af5fa2bdf079ac4ad8a617c454fd01b549ca824f37bd7d2f9fcc20f41507050',
      x86_64: 'f77d89ba219257e2b2d97776b0df5407e40b33dcca0d0ca49d0970145009c31e'
  })

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
