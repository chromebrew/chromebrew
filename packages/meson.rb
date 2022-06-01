require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.62.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.62.0_armv7l/meson-0.62.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.62.0_armv7l/meson-0.62.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.62.0_i686/meson-0.62.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.62.0_x86_64/meson-0.62.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '501b9eba0dc7f1ce2f3581bbb273ad7c5414544ce354a6789b84fccd5bea6028',
     armv7l: '501b9eba0dc7f1ce2f3581bbb273ad7c5414544ce354a6789b84fccd5bea6028',
       i686: '4d85a1e9b8906f5cd9a601f479e24a2a6ad176efbdaa3cb78a43de274ceff7dc',
     x86_64: 'c65f899ab06d628a4621a7b0badae7d0c96085bf9f971f2996f8e7e2c8ae2833'
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
