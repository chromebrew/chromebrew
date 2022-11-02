require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.63.3'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.3_armv7l/meson-0.63.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.3_armv7l/meson-0.63.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.3_i686/meson-0.63.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.3_x86_64/meson-0.63.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd3632253e99c088d23d9eb7d1cde3c8b6bb073fad869cb57c0f13a0ea9db3e74',
     armv7l: 'd3632253e99c088d23d9eb7d1cde3c8b6bb073fad869cb57c0f13a0ea9db3e74',
       i686: '7b2d880b4a71623a2dbec78b9c6bd467c3b3c7876c84cd672a96b52497071050',
     x86_64: '7c9fcc5a0289902797a266d436b51bdfd75051aad4accb42a6e8b69f2419984b'
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
