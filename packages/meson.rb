require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.64.1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.64.1_armv7l/meson-0.64.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.64.1_armv7l/meson-0.64.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.64.1_i686/meson-0.64.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.64.1_x86_64/meson-0.64.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b1dddc4342c0afe9627533ea94cddcd34e2c6b0d3dd227b933eb3e69807cb531',
     armv7l: 'b1dddc4342c0afe9627533ea94cddcd34e2c6b0d3dd227b933eb3e69807cb531',
       i686: 'c934b00d3b9b9ca144fb5d134e079d446f5e0f3624ab8d9782a4d7c4018193e8',
     x86_64: 'f0f16322ba9dc7448cb5b1c15aea7c8b7d6b19e29df0ab773aefe6b007bd01a3'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
