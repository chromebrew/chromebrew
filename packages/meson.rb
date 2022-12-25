require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '1.0.0'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.0.0-py3.11_armv7l/meson-1.0.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.0.0-py3.11_armv7l/meson-1.0.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.0.0-py3.11_i686/meson-1.0.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/1.0.0-py3.11_x86_64/meson-1.0.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '58fdc7699c6edf05d35a8449f10f8a366556074fc85af7c88a77dcb72dee142a',
     armv7l: '58fdc7699c6edf05d35a8449f10f8a366556074fc85af7c88a77dcb72dee142a',
       i686: 'e048ad48e24777ab55158bdddd7f839c8eafd4353334737c4958deac1b9bfdf7',
     x86_64: 'c14ad3a8aad7ae3c4ff7392cd4bf5d472563904551826875523a9339a793676d'
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
