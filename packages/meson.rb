require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.55.3'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson/archive/0.55.3.tar.gz'
  source_sha256 '2b276df50c5b13ccdbfb14d3333141e9e7985aca31b60400b3f3e0be2ee6897e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.55.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.55.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.55.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.55.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'dc4075b1285709e2a3701d906a5096e7c6e721f0f1998713bec433676f5671d0',
     armv7l: 'dc4075b1285709e2a3701d906a5096e7c6e721f0f1998713bec433676f5671d0',
       i686: 'ca7b2fb537278a2083c536fd0208edab55adba18b90884dd47c55449c05e6250',
     x86_64: '79921f5b27571e342c7414e34f15dff0e7a610277ace4242043f50410a363d95',
  })

  depends_on 'ninja'
  depends_on 'setuptools'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
