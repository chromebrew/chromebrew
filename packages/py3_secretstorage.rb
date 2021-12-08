require 'package'

class Py3_secretstorage < Package
  description 'Python bindings to Freedesktop.org Secret Service API'
  homepage 'https://secretstorage.readthedocs.io/'
  @_ver = '3.3.1'
  version "#{@_ver}-1"
  license 'BSD-3'
  compatibility 'all'
  source_url 'https://github.com/mitya57/secretstorage.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1-1_armv7l/py3_secretstorage-3.3.1-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1-1_armv7l/py3_secretstorage-3.3.1-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1-1_i686/py3_secretstorage-3.3.1-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_secretstorage/3.3.1-1_x86_64/py3_secretstorage-3.3.1-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd4ad62dfb50e650044251210b378376032db4cbf7b8e71f7e4ff93043e90f02d',
     armv7l: 'd4ad62dfb50e650044251210b378376032db4cbf7b8e71f7e4ff93043e90f02d',
       i686: 'bf62dea7557831be837dce0e689f15a2f47ba2a21259ff927a0a174c2f384009',
     x86_64: '4d3a6ffea04238524479459433255f0659e9a4bec597ed7ff2b325b026a2958f'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_cryptography'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
