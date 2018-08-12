require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.47.1'
  source_url 'https://github.com/mesonbuild/meson/releases/download/0.47.1/meson-0.47.1.tar.gz'
  source_sha256 'd673de79f7bab064190a5ea06140eaa8415efb386d0121ba549f6d66c555ada6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.47.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.47.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.47.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.47.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '70044685fed7440fbce8f433cf3d8912545e1d99f176cc374a61010dee9d6da8',
     armv7l: '70044685fed7440fbce8f433cf3d8912545e1d99f176cc374a61010dee9d6da8',
       i686: '0894590fed44551d2e56f4ce419306b115c0f00387a87a78ce34bf5a77d6292b',
     x86_64: '41499c5d9e9d27413fac18ab977e5011abf22baeb8738c42ae98a187645f2ea1',
  })

  depends_on 'ninja'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
