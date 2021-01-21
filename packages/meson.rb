require 'package'

class Meson < Package
  description 'The Meson Build System'
  homepage 'http://mesonbuild.com/'
  version '0.56.2'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson/archive/0.56.2.tar.gz'
  source_sha256 'aaae961c3413033789248ffe6762589e80b6cf487c334d0b808e31a32c48f35f'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.56.2-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.56.2-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.56.2-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/meson-0.56.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'c463376e6d041ec860ea6ca4a02d852260ca289805e3822442173fc007fb9e43',
      armv7l: 'c463376e6d041ec860ea6ca4a02d852260ca289805e3822442173fc007fb9e43',
        i686: '78bb992b3336d189ee5f73fc9b19697b630974913d906d2d86ef71dd963736f4',
      x86_64: 'c44b86828e222b236133d4e27c0437616bf9bb1503b3acfcd48ca7b655cdf50d',
  })

  depends_on 'ninja'
  depends_on 'setuptools'

  def self.install
    system "python3 setup.py install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
