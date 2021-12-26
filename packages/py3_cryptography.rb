require 'package'

class Py3_cryptography < Package
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  @_ver = '36.0.0'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/pyca/cryptography.git'
  git_hashtag @_ver

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/36.0.0_armv7l/py3_cryptography-36.0.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/36.0.0_armv7l/py3_cryptography-36.0.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/36.0.0_i686/py3_cryptography-36.0.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/36.0.0_x86_64/py3_cryptography-36.0.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '9671703e41b0eba9780b2b1dbd4fa53c5509119bd06fed1b9f320169945ebdb7',
     armv7l: '9671703e41b0eba9780b2b1dbd4fa53c5509119bd06fed1b9f320169945ebdb7',
       i686: '0add4c30b9b356e7db03071eb02c5151c5978b31239e11879b53f18d49c5392f',
     x86_64: '888da2eea6ed932f686569af840e3bbdbfd24ca4e164f783c78a5180c191a536'
  })

  depends_on 'py3_cffi'
  depends_on 'py3_six'
  depends_on 'py3_typing_extensions'
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
