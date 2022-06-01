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
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.37.0_i686/py3_wheel-0.37.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_wheel/0.37.0_x86_64/py3_wheel-0.37.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f7a9f3dd8567bd0f15135aed8a7aa4a2dc4a28474a125ebfc745ac0d3bc7010b',
     armv7l: 'f7a9f3dd8567bd0f15135aed8a7aa4a2dc4a28474a125ebfc745ac0d3bc7010b',
       i686: '56876fb356f9e0a83a9c283661de59776c41ffde0a7f33ebb8f69353a2098fa7',
     x86_64: 'd22903d95f42433d09d17ee3d6b5c1d188553334d3f371df2ac4cd0b5c425c0c'
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
