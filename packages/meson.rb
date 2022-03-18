require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.61.3'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.61.3_armv7l/meson-0.61.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.61.3_armv7l/meson-0.61.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.61.3_i686/meson-0.61.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.61.3_x86_64/meson-0.61.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6eaaf072f96c0e188081cb326e364881de6c565f4bd6e6e4a715443a6347cf30',
     armv7l: '6eaaf072f96c0e188081cb326e364881de6c565f4bd6e6e4a715443a6347cf30',
       i686: '18788f704936ea4780d23bf8c62cc92c285061f8234319f9cda94183aaf2f524',
     x86_64: '4e6a6c90dd4bd7383c63d8b8e4c4bbddac0bf01b11cfcb371f991c2554ece7d6'
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
