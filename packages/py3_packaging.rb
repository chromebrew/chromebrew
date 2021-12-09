require 'package'

class Py3_packaging < Package
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  @_ver = '21.0'
  version @_ver
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pypa/packaging.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.0_armv7l/py3_packaging-21.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.0_armv7l/py3_packaging-21.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.0_i686/py3_packaging-21.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_packaging/21.0_x86_64/py3_packaging-21.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'fd26fc1784f6b275c553327589b975e5456214629caa0469f5dfb4cbf91267ce',
     armv7l: 'fd26fc1784f6b275c553327589b975e5456214629caa0469f5dfb4cbf91267ce',
       i686: '4f16b10ad81f01ccc9a2932a112f5b02b5fd04f444867bbd2db1307bbc44fa1b',
     x86_64: '4715e0e8bb2ba57826e08e7c5e270f2258765ca1916a72e4549f4d92d4bb22c8'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
