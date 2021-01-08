require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.56.1'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson/archive/0.56.1.tar.gz'
  source_sha256 'db3545231bb8f3ae3186a1a0f49f0acd239724af91781b783e843b80400f10ec'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.56.1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.56.1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.56.1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.56.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'af7616839ef04f824be003d0a534a5a774ef53ed51ff6cafdd678c4744b09787',
      armv7l: 'af7616839ef04f824be003d0a534a5a774ef53ed51ff6cafdd678c4744b09787',
        i686: '6ad48fdd56b57d8fbbdf11a7c4a76d684937f5868dec8ebf1afe41b60a3d9655',
      x86_64: 'b4eca2d237740bfafbc211adc8b352685335c46db29f3609e848c1931f137e1a',
  })



  depends_on 'ninja'
  depends_on 'setuptools'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
