require 'package'

class Py3_cryptography < Package
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  @_ver = '3.4.7'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyca/cryptography.git'
  git_hashtag @_ver

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/3.4.7_i686/py3_cryptography-3.4.7-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/3.4.7_x86_64/py3_cryptography-3.4.7-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    i686: '4ce8cefc8f67c30648ae3cf5d9ce711b7904f30e89fa8dc962fabd7f7fc0fcb6',
  x86_64: 'f95da04a5ebbb8b3d12b12ab90f244f2d45445e3eb004e62177966396ddbd2b9'
  })

  depends_on 'py3_cffi'
  depends_on 'py3_six'
  depends_on 'py3_setuptools_rust' => :build
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
