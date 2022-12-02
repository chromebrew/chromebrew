require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.64.1'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.64.1-py3.11_armv7l/meson-0.64.1-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.64.1-py3.11_armv7l/meson-0.64.1-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.64.1-py3.11_i686/meson-0.64.1-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.64.1-py3.11_x86_64/meson-0.64.1-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2c823c8b85bac3f2e46f64d2ca83445db7c0746973a99ef4617e9a98f5b03f78',
     armv7l: '2c823c8b85bac3f2e46f64d2ca83445db7c0746973a99ef4617e9a98f5b03f78',
       i686: '2292157273f6368207dc42c7bdd099f36d1905bb9f842df0a2a7372e61388c1e',
     x86_64: 'e7f0e20cb77a4cc9fb850a1e86671af30e528758f2385ccc0b7ebd8b4f31a230'
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
