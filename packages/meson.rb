require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.61.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'file:///usr/local/tmp/packages/meson-0.61.0-chromeos-armv7l.tpxz',
     armv7l: 'file:///usr/local/tmp/packages/meson-0.61.0-chromeos-armv7l.tpxz',
       i686: 'file:///usr/local/tmp/packages/meson-0.61.0-chromeos-i686.tpxz',
     x86_64: 'file:///usr/local/tmp/packages/meson-0.61.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5829e292c2e6698101d980cd4f66063d82b2b7444d95f93edc2d6cdfbd75e6c0',
     armv7l: '5829e292c2e6698101d980cd4f66063d82b2b7444d95f93edc2d6cdfbd75e6c0',
       i686: '04ef88262a90a7b93f430c40ed16edd4688790782a645bb8c3408e2ea7839eeb',
     x86_64: '322086d4553f6698a2112943eff7ac2a42f3f840e930a8a0ae863022a4fa4d39'
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
