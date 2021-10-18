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
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.11.0_x86_64/py3_pycryptodomex-3.11.0-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '10934e94f68d2a69da0997d04bc12d2a3829d7b34d51c6e11cfc50a2f1cf29b2',
     armv7l: '10934e94f68d2a69da0997d04bc12d2a3829d7b34d51c6e11cfc50a2f1cf29b2',
     x86_64: '8f554bafacdf6b784796f53018c1e8997664b0944428c58399b5b094c09cd225'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
