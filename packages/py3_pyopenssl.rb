require 'package'

class Py3_pyopenssl < Package
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  @_ver = '21.0.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pyca/pyopenssl.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyopenssl/21.0.0_armv7l/py3_pyopenssl-21.0.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyopenssl/21.0.0_armv7l/py3_pyopenssl-21.0.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyopenssl/21.0.0_i686/py3_pyopenssl-21.0.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyopenssl/21.0.0_x86_64/py3_pyopenssl-21.0.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '329cf0ad0b08c669918aa0c7c1f1a728678eb62c0f566131a83c8aa7a8fa7cc5',
     armv7l: '329cf0ad0b08c669918aa0c7c1f1a728678eb62c0f566131a83c8aa7a8fa7cc5',
       i686: '8d6f5beb6cf6002bfef590c189e896463b814513655d459da6d33de6fb72aeae',
     x86_64: 'f37bb9d35f279a7c538532e5a9b13b259101c8d81470b7bdd1be5f08c32bb60a'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
