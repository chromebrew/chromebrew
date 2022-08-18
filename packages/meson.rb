require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.63.1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.1_armv7l/meson-0.63.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.1_armv7l/meson-0.63.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.1_i686/meson-0.63.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.1_x86_64/meson-0.63.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '66d12e7c85e9dc3f901ecf020181649144a1f219d0f3b7d4ff8832587ecf50b3',
     armv7l: '66d12e7c85e9dc3f901ecf020181649144a1f219d0f3b7d4ff8832587ecf50b3',
       i686: 'e5c1e65482854b5f31e1f36e7e92711eedc2b0fe7b10cf6145910691e223eac5',
     x86_64: '9df15c32f27a89dd68aab89c395f09198ed831c6a8db62ed3ac59f02fb6d5b78'
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
