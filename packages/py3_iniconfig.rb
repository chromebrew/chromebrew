require 'package'

class Py3_iniconfig < Package
  description 'Iniconfig provides simple config-ini parsing.'
  homepage 'https://github.com/pytest-dev/iniconfig/'
  @_ver = '1.1.1'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/iniconfig.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_iniconfig/1.1.1_armv7l/py3_iniconfig-1.1.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_iniconfig/1.1.1_armv7l/py3_iniconfig-1.1.1-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_iniconfig/1.1.1_x86_64/py3_iniconfig-1.1.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd8faa31c9d0d32fdcb8580ffe407a084a7a3a761eb998b73407e5df41ae715af',
     armv7l: 'd8faa31c9d0d32fdcb8580ffe407a084a7a3a761eb998b73407e5df41ae715af',
     x86_64: '29d178df195e9c668fb9a74463ddaa98988a89d27c702b1f2479b4e70e527e62'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
