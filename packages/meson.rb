require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.63.2'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.2_armv7l/meson-0.63.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.2_armv7l/meson-0.63.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.2_i686/meson-0.63.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.2_x86_64/meson-0.63.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f12540afa039e6d33a0567aa8d05f11e41118311c61d94fd27e9fc57e92a1e8f',
     armv7l: 'f12540afa039e6d33a0567aa8d05f11e41118311c61d94fd27e9fc57e92a1e8f',
       i686: '3de10a2ef8ce12c2e0f9b2e931ef38313252fac2544f48cd1c2a81d9779fa0ce',
     x86_64: 'c60693ebee824f77a60ae0485a97b1381c85877b56c758babfbe50552e9afd95'
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
