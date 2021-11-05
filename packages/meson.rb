require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.60.1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.60.1_armv7l/meson-0.60.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.60.1_armv7l/meson-0.60.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.60.1_i686/meson-0.60.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.60.1_x86_64/meson-0.60.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f6b7fd0b98284d3c9a59e5e9335b62d6d32793c1017319d8d3d0a6355cc344b4',
     armv7l: 'f6b7fd0b98284d3c9a59e5e9335b62d6d32793c1017319d8d3d0a6355cc344b4',
       i686: 'd6748b62e8904e83d2b44f91f707fbc2fb0078bc8ab7f65284c1a18cc2e34e27',
     x86_64: 'eb2b5ea1a98e4dcbe00b8c064d91a01d6a7003b661dbd14f751ccacb75edfe58'
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
