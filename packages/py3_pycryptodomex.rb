require 'package'

class Py3_pycryptodomex < Package
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  @_ver = '3.11.0'
  version @_ver
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'https://github.com/Legrandin/pycryptodome.git'
  git_hashtag "v#{@_ver}x"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.11.0_armv7l/py3_pycryptodomex-3.11.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.11.0_armv7l/py3_pycryptodomex-3.11.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.11.0_i686/py3_pycryptodomex-3.11.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.11.0_x86_64/py3_pycryptodomex-3.11.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5ac8c08018c0de633984bdfd40526854f65f085ff54c61681db4d4fe165a247a',
     armv7l: '5ac8c08018c0de633984bdfd40526854f65f085ff54c61681db4d4fe165a247a',
       i686: 'c367ebbc87ed4ce3a6078605cfd52c937e4fdbd56251fcefaa3fa106068d9601',
     x86_64: 'ac4e5244090c83f5b1a28541f797dcb96c92ffd1213647c05b4913b962507d41'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
