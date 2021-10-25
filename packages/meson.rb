require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.60.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.60.0_armv7l/meson-0.60.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.60.0_armv7l/meson-0.60.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.60.0_i686/meson-0.60.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.60.0_x86_64/meson-0.60.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '07781231495f5ef90e10a67c57bb4f9749663d3ea298be2b0088d55711dfb066',
     armv7l: '07781231495f5ef90e10a67c57bb4f9749663d3ea298be2b0088d55711dfb066',
       i686: '70727e13f8bee1caccd3b4dbf048a35999c6d33a7a66c02ce5553a626bbd00ea',
     x86_64: 'e12c49efcba463c3d59ba7ffea0e0302e0a83238c6151b95bbd0684897806905'
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
