require 'package'

class Py3_pyopenssl < Package
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  @_ver = '21.0.0'
  version "#{@_ver}-py3.11"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/pyca/pyopenssl.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyopenssl/21.0.0-py3.11_armv7l/py3_pyopenssl-21.0.0-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyopenssl/21.0.0-py3.11_armv7l/py3_pyopenssl-21.0.0-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyopenssl/21.0.0-py3.11_i686/py3_pyopenssl-21.0.0-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pyopenssl/21.0.0-py3.11_x86_64/py3_pyopenssl-21.0.0-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '312537cf2ebe6f1f055906df47f3fc415e37d888aae029ce90494b39cd28fdb7',
     armv7l: '312537cf2ebe6f1f055906df47f3fc415e37d888aae029ce90494b39cd28fdb7',
       i686: '93c205133b6564638af1ea4bf7c850641586aa56dacb1d569f87f940c69beb41',
     x86_64: 'b9756c7860ebdf868cf7ef6bee00885bfe2ca5f0a389ef589f75dc3870c112d8'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
