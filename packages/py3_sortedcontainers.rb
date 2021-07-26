require 'package'

class Py3_sortedcontainers < Package
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'http://www.grantjenks.com/docs/sortedcontainers/'
  @_ver = '2.3.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/grantjenks/python-sortedcontainers.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.3.0_armv7l/py3_sortedcontainers-2.3.0-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.3.0_armv7l/py3_sortedcontainers-2.3.0-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.3.0_i686/py3_sortedcontainers-2.3.0-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_sortedcontainers/2.3.0_x86_64/py3_sortedcontainers-2.3.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '3fc796fddd1d7856d5c07e690078b7e0bc728dce970241beffd7a37fb082df30',
     armv7l: '3fc796fddd1d7856d5c07e690078b7e0bc728dce970241beffd7a37fb082df30',
       i686: '03fb1cb1d88f9b7b7d9257d84c016f74b52e676269e6dce3518d4f226f384c3b',
     x86_64: '6a5c717c5e740bd07beb92c70650791d5fad7ff691fa62cf0ba40c589a35a38b'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
