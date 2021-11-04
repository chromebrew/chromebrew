require 'package'

class Meson < Package
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  @_ver = '0.59.1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/mesonbuild/meson.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.59.1_armv7l/meson-0.59.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.59.1_armv7l/meson-0.59.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.59.1_i686/meson-0.59.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/meson/0.59.1_x86_64/meson-0.59.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b476fa2a9fb9b7936b2677fe54497d6c8b9f05447303ea4c3ba93fcf58d1914b',
     armv7l: 'b476fa2a9fb9b7936b2677fe54497d6c8b9f05447303ea4c3ba93fcf58d1914b',
       i686: '8851b08384d500adc273b10ece731f3e93ac11199734d2d26fca32b0a2fc2337',
     x86_64: 'ae500b01a538d74935049b5701d5efdfb99aa08628147b7228b0359a5a592d79'
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
