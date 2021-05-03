require 'package'

class Py3_six < Package
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://six.readthedocs.io/'
  @_ver = '1.15.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/benjaminp/six.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_six/1.15.0_armv7l/py3_six-1.15.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_six/1.15.0_armv7l/py3_six-1.15.0-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_six/1.15.0_i686/py3_six-1.15.0-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_six/1.15.0_x86_64/py3_six-1.15.0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '7fd52ee11377bea79689beb61606479c1de3df30dfed40281a58591c57872166',
     armv7l: '7fd52ee11377bea79689beb61606479c1de3df30dfed40281a58591c57872166',
       i686: 'a7b172a5e44d2d000a843d478e9f04b9d5d2c792eeca4ef791dec1de206396b9',
     x86_64: '00be47e6c38bae5b71b2a965c2e9d63381b18ec66dc7cd10b61c56e14653790d'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
