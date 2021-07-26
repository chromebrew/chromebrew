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
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyopenssl/20.0.1_x86_64/py3_pyopenssl-20.0.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
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
