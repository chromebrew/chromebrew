require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.60.3'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.60.3_armv7l/meson-0.60.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.60.3_armv7l/meson-0.60.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.60.3_i686/meson-0.60.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.60.3_x86_64/meson-0.60.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5acf3747c967de025273d854612aec0a766c8429c4bc70439e9492f744ae45fc',
     armv7l: '5acf3747c967de025273d854612aec0a766c8429c4bc70439e9492f744ae45fc',
       i686: 'a6a87b0dca65adf2524339ac995841547eaedfc51b65a2f2606d2967506561d6',
     x86_64: '8012c5627b2a6c75786168f7bab86697627c00ee63f588abf1d87bb37df91d93'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
