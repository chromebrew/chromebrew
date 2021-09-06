require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.59.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.59.0_armv7l/meson-0.59.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.59.0_armv7l/meson-0.59.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.59.0_i686/meson-0.59.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.59.0_x86_64/meson-0.59.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '4cdb34e921d39f0a7439543a241941d869fc4c7390e2a5c33d0cd6485996bbc6',
     armv7l: '4cdb34e921d39f0a7439543a241941d869fc4c7390e2a5c33d0cd6485996bbc6',
       i686: 'd91ab13dcce6d3f112a9275a160baea1ec5663fb215fe717d6543fa723b69d90',
     x86_64: '9358e0c8dc83a744fc2ceb24119d918dc5007334d9670cdf523e15e4b083d29d'
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
