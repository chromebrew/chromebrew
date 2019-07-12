require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.51.1'
  source_url 'https://github.com/mesonbuild/meson/releases/download/0.51.1/meson-0.51.1.tar.gz'
  source_sha256 'f27b7a60f339ba66fe4b8f81f0d1072e090a08eabbd6aa287683b2c2b9dd2d82'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.51.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.51.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.51.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.51.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6173c80dfccf2978adcc3a67470a12177f1ff8678dcffc6c1bfff3fe1ffb9978',
     armv7l: '6173c80dfccf2978adcc3a67470a12177f1ff8678dcffc6c1bfff3fe1ffb9978',
       i686: '009b3313c5c22c5208ba9597ef6e7796df0c3a3cf74484f5abca4f0b168bf54a',
     x86_64: '5da9467ea3d2a9e05870fa5a584904a4d533a296852d7b20407fe430fee620a0',
  })

  depends_on 'ninja'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
