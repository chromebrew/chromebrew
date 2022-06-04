require 'package'

class Py3_cryptography < Package
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  @_ver = '37.0.2'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyca/cryptography.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/37.0.2_armv7l/py3_cryptography-37.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/37.0.2_armv7l/py3_cryptography-37.0.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/37.0.2_i686/py3_cryptography-37.0.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/37.0.2_x86_64/py3_cryptography-37.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3c2e017334e84834e81d67a709c86b430d8f419c2f5081ce31293fe83f850e0f',
     armv7l: '3c2e017334e84834e81d67a709c86b430d8f419c2f5081ce31293fe83f850e0f',
       i686: 'b748fd83659b4fd7f64d3791d2c1385df7e468b2910299c2010b2fdf9db904e1',
     x86_64: 'fb0b79a2477bef16ac69968e61d8ee20238dceb979b0173e54f8f1f476c71477'
  })

  depends_on 'py3_cffi'
  depends_on 'py3_six'
  depends_on 'py3_typing_extensions'
  depends_on 'py3_setuptools_rust' => :build
  depends_on 'py3_pycparser' => :build

  def self.build
    system "SETUPTOOLS_SCM_PRETEND_VERSION=#{@_ver} python3 -m build #{PY3_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 -m installer #{PY3_INSTALLER_OPTIONS}"
  end
end
