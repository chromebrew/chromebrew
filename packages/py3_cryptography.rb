require 'package'

class Py3_cryptography < Package
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  @_ver = '35.0.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyca/cryptography.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/35.0.0_armv7l/py3_cryptography-35.0.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/35.0.0_armv7l/py3_cryptography-35.0.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/35.0.0_i686/py3_cryptography-35.0.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/35.0.0_x86_64/py3_cryptography-35.0.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '565e29e043e7fb83c7cd02c619b2611620689959e1c83ab27a7827b943382f40',
     armv7l: '565e29e043e7fb83c7cd02c619b2611620689959e1c83ab27a7827b943382f40',
       i686: 'a3bd7ca74b310b4581658eb9ee97c6358f78fb2e21305be74f43cd38014889c9',
     x86_64: 'b4980330c51dfcfc6f1d8fb9cdd15bed2081db54331db70c805bf5cd5ab88a96'
  })

  depends_on 'py3_cffi'
  depends_on 'py3_six'
  depends_on 'py3_setuptools_rust' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'rust' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
