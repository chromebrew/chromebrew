require 'package'

class Py3_wheel < Package
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  @_ver = '0.37.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pypa/wheel.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.37.0_armv7l/py3_wheel-0.37.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.37.0_armv7l/py3_wheel-0.37.0-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.37.0_x86_64/py3_wheel-0.37.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'a8e5f1c47f46cc3ce4007f8ccb57ec3507e1bf2bc0502800bcbcca12b5017753',
     armv7l: 'a8e5f1c47f46cc3ce4007f8ccb57ec3507e1bf2bc0502800bcbcca12b5017753',
     x86_64: '3928e780011faae705cbdf6f0e35130e05f810e6565b256d807d7b0058fd073c'
  })

  depends_on 'py3_setuptools' => :build
  depends_on 'py3_packaging'

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
