require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.58.2'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.58.1_i686/meson-0.58.1-chromeos-i686.tpxz',
 aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.58.2_armv7l/meson-0.58.2-chromeos-armv7l.tpxz',
  armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.58.2_armv7l/meson-0.58.2-chromeos-armv7l.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.58.2_x86_64/meson-0.58.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: '81211605d926df2868241b31726224bfe41f816faa7095a123e9c78dea680a7a',
 aarch64: '725b270200e40fd3ebbaa4d4312f6fa6cb76422c92bfaa125322b74696f04b5e',
  armv7l: '725b270200e40fd3ebbaa4d4312f6fa6cb76422c92bfaa125322b74696f04b5e',
  x86_64: '4330d50cc93deb873f60fb3dda818f9875c9967b938c66f5577245a4fdbebbd2'
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
