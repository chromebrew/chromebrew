require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.61.1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.61.1_armv7l/meson-0.61.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.61.1_armv7l/meson-0.61.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.61.1_i686/meson-0.61.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.61.1_x86_64/meson-0.61.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '89471f377e91165418858f9dfb13e524e816f878ea3944636af042c9ddb42ffb',
     armv7l: '89471f377e91165418858f9dfb13e524e816f878ea3944636af042c9ddb42ffb',
       i686: 'b941660b357c7c215ae2da568f74184106acf942ba5e3452058f6c1b57e53637',
     x86_64: 'a17eb696f9f1ef5c6d03143f0f8c7ad2ee0b7454604660f302c738402e0f8197'
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
