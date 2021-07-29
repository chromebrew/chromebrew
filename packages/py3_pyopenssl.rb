require 'package'

class Py3_pyopenssl < Package
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  @_ver = '20.0.1'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pyca/pyopenssl.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyopenssl/20.0.1_armv7l/py3_pyopenssl-20.0.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyopenssl/20.0.1_armv7l/py3_pyopenssl-20.0.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyopenssl/20.0.1_i686/py3_pyopenssl-20.0.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyopenssl/20.0.1_x86_64/py3_pyopenssl-20.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd098a318914cb131f7e1b90ae09056e6273a79d0da73636f981c5a88d4990f89',
     armv7l: 'd098a318914cb131f7e1b90ae09056e6273a79d0da73636f981c5a88d4990f89',
       i686: '66e2046576f17e8dd612be3a9dbe63ec9f636759f3cc69af6db30938a78623df',
     x86_64: '071477601beeca4bd49dc5975a9fe0d4ee7050135538086f3218d03fb1932a5a'
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
