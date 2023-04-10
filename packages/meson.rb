require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '1.1.0'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.1.0-py3.11_armv7l/meson-1.1.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.1.0-py3.11_armv7l/meson-1.1.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.1.0-py3.11_i686/meson-1.1.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.1.0-py3.11_x86_64/meson-1.1.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bac4a4abb5cd9c870ab3b2bb07545cd2c1ac31a71168398a47c97086bbf56be5',
     armv7l: 'bac4a4abb5cd9c870ab3b2bb07545cd2c1ac31a71168398a47c97086bbf56be5',
       i686: 'f24be3abf488387cd5fa4920aab132a396502ce9f5f3d524d3a41efdf08d3939',
     x86_64: 'befbe36af731aba0723771b98eaceae4f54406607253de3863e41939a615aa87'
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
