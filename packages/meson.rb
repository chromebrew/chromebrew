require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.58.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.58.0_armv7l/meson-0.58.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.58.0_armv7l/meson-0.58.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.58.0_i686/meson-0.58.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.58.0_x86_64/meson-0.58.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd9fe1f557b5766a4e849dd5cf8604a012a94f86836b1b829167d1565956e3fa0',
     armv7l: 'd9fe1f557b5766a4e849dd5cf8604a012a94f86836b1b829167d1565956e3fa0',
       i686: 'ca9818d5f7871da3d256220c31ce4b282a62aa96abcfe19c15e5635e6d3974dc',
     x86_64: '07c276fe4f9581b8a9afa408d56110e2234f00f26f610783add66975ca697b1b'
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
