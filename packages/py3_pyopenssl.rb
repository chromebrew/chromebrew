require 'package'

class Py3_pyopenssl < Package
  description 'pyOPENSSL is a python wrapper module around the OpenSSL library.'
  homepage 'https://pyopenssl.org/'
  version '20.0.1'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pyca/pyopenssl/archive/20.0.1.tar.gz'
  source_sha256 'c5de94c6313dac399ac5bd18c21faacccaaf901ed91401eafb470366e8ac8619'

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{CREW_SETUP_PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{CREW_SETUP_PY_INSTALL_OPTIONS}"
  end
end
