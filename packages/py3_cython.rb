require 'package'

class Py3_cython < Package
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  @_ver = '0.29.24'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/cython/cython.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.24_armv7l/py3_cython-0.29.24-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.24_armv7l/py3_cython-0.29.24-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.24_i686/py3_cython-0.29.24-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cython/0.29.24_x86_64/py3_cython-0.29.24-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '015010c91705dda3e05a05ffc0f5ee62b460e67d5dc58c4b50e7412cd5d528b4',
     armv7l: '015010c91705dda3e05a05ffc0f5ee62b460e67d5dc58c4b50e7412cd5d528b4',
       i686: 'f738a39df78d2b74cc58b4d25a6f66b857328a1887035bdaaccc1e78ab131a63',
     x86_64: 'a15ac94aa1a7da63465a28d2c91f9c1494a08762894d9b1092e9b86cfa89466b'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
