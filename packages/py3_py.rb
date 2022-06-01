require 'package'

class Py3_py < Package
  description 'Py is a library with cross-python path, ini-parsing, io, code, log facilities.'
  homepage 'https://py.readthedocs.io/'
  @_ver = '1.11.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/py.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.11.0_armv7l/py3_py-1.11.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.11.0_armv7l/py3_py-1.11.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.11.0_i686/py3_py-1.11.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.11.0_x86_64/py3_py-1.11.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0a80555715238c84c7e63f892b17f36ae1dc180e6ba54085a3d5178d5467e16f',
     armv7l: '0a80555715238c84c7e63f892b17f36ae1dc180e6ba54085a3d5178d5467e16f',
       i686: 'e950aa9004e10ddec0de76355c7b9c13e73cdef0cbb629cc3a95a10d14cb87f4',
     x86_64: '25e1138bcae0d8d30bf50a851474a267d05d3779b8d4fc45b4038306484ba5c3'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
