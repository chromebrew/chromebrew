require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '1.1.1'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.1.1-py3.11_armv7l/meson-1.1.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.1.1-py3.11_armv7l/meson-1.1.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.1.1-py3.11_i686/meson-1.1.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.1.1-py3.11_x86_64/meson-1.1.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b115bbeb20031eb07f90b0fc31f5dd9e7d9cbfccae9ea6c395e6a1161e5fbdaa',
     armv7l: 'b115bbeb20031eb07f90b0fc31f5dd9e7d9cbfccae9ea6c395e6a1161e5fbdaa',
       i686: '02650d3abb00ea2d2ff20e91de4d2b617a2e2ddefb062326eed3ae943e9e1695',
     x86_64: '807a71257719493fbb5faca689338c6eb3e01174a59d13add1d34d829428cadd'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
