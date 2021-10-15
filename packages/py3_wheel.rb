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
    aarch64: '429814feb8aa384455bb28b5cced0b29e90c2f51b13190787092679aaadb0082',
     armv7l: '429814feb8aa384455bb28b5cced0b29e90c2f51b13190787092679aaadb0082',
     x86_64: 'd10f5d7a288ad1ed61fe0db6161f23292c2edd185d672e2089e1648f9d69b803'
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
