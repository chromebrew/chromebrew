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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/3.4.7_armv7l/py3_cryptography-3.4.7-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/3.4.7_armv7l/py3_cryptography-3.4.7-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/35.0.0_i686/py3_cryptography-35.0.0-chromeos-i686.tpxz',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/35.0.0_x86_64/py3_cryptography-35.0.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8bd03b0ab62ae17ce3c4cdeb4e209a5d761000c1327748bddc75de4d4d422c90',
     armv7l: '8bd03b0ab62ae17ce3c4cdeb4e209a5d761000c1327748bddc75de4d4d422c90',
    i686: '82673e4046700c354823e083999d2471a3c3e9bffa5963e97e0f2d634a1b718e',
  x86_64: 'e3bd7320013ab98ef9e64163023b05dca9b4bcdf11706f04d1088a29be2eb3f6'
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
