require 'package'

class Py3_py < Package
  description 'Py is a library with cross-python path, ini-parsing, io, code, log facilities.'
  homepage 'https://py.readthedocs.io/'
  @_ver = '1.10.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pytest-dev/py.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.10.0_armv7l/py3_py-1.10.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.10.0_armv7l/py3_py-1.10.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.10.0_i686/py3_py-1.10.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_py/1.10.0_x86_64/py3_py-1.10.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '87216dfa6e6dea6bf5d2a2b706a054db9affbb78413de08b14df23711eeeb053',
     armv7l: '87216dfa6e6dea6bf5d2a2b706a054db9affbb78413de08b14df23711eeeb053',
       i686: 'f9b7e26edf6d2a5b605cf16c0ef76ad590b07472f7d9741b635286794de3ff0b',
     x86_64: 'daf69c756cec7668d0a3aea2d2dd54e7634a5a0650a6452b8a3e004f001571df'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
