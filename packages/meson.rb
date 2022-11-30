require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.64.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.64.0_armv7l/meson-0.64.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.64.0_armv7l/meson-0.64.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.64.0_i686/meson-0.64.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.64.0_x86_64/meson-0.64.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '390bbe54efc8b46ecbfa06dd89d90d8f2a45bb7e785ffa7d421e3c5372e43d34',
     armv7l: '390bbe54efc8b46ecbfa06dd89d90d8f2a45bb7e785ffa7d421e3c5372e43d34',
       i686: '9242e8ef0d5ae7c2fde6f8a3bf20dc6e127847f66fa8a53c9799a68be4fcf7c5',
     x86_64: 'f46f931ebfceb1576f52082e27a3d6f55668885d1fea7c1a8678442755db6e7c'
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
