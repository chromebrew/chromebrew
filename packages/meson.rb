require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.63.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.0_armv7l/meson-0.63.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.0_armv7l/meson-0.63.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.0_i686/meson-0.63.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.63.0_x86_64/meson-0.63.0-chromeos-x86_64.tar.zst',
  })
  binary_sha256({
    aarch64: '89fc79291165d5913901005a082e8126febf8ed62f8fcfd79a535d24757f1b5d',
     armv7l: '89fc79291165d5913901005a082e8126febf8ed62f8fcfd79a535d24757f1b5d',
       i686: '528d802bf0c2d479c38a709126aa0fce154acdd35dd66984a543d76a7bee8ae9',
     x86_64: '0664f17c2d76bcb5332f9360ebf135869fc52fbb081b15a0abfe7a4cb4a36211',
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
