require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.59.2'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.59.2_armv7l/meson-0.59.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.59.2_armv7l/meson-0.59.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.59.2_i686/meson-0.59.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.59.2_x86_64/meson-0.59.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '756eee2c318484bfb3a69ef6c1c28407500458aa37cdb35fdf51e105fd52cca0',
     armv7l: '756eee2c318484bfb3a69ef6c1c28407500458aa37cdb35fdf51e105fd52cca0',
       i686: '937b09f662d9d0d9f034b29ddf568f917bb47d0df473ea80a9a19280ee621785',
     x86_64: '4c5cf52803c86b5b70c6e2d4166b0e48ae7dfc563991672c64d4d5ad040d363e'
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
