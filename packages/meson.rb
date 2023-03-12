require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '1.0.1'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.0.1-py3.11_i686/meson-1.0.1-py3.11-chromeos-i686.tar.zst',
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.0.1-py3.11_armv7l/meson-1.0.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.0.1-py3.11_armv7l/meson-1.0.1-py3.11-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.0.1-py3.11_x86_64/meson-1.0.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
       i686: 'b51bfa30ec8d9112d8f8f418033400a529fec95ee430e46cca5da8b0567b1a83',
    aarch64: 'b2528b3d8f6b1220c11426d2e8be5223647a2d643345f1d549b958c8aeac52a0',
     armv7l: 'b2528b3d8f6b1220c11426d2e8be5223647a2d643345f1d549b958c8aeac52a0',
     x86_64: '6ca576d33b33ec1a216185024867f2555d39f69c91b3e86fbadc00c4c97bf016'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
