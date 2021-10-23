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
    aarch64: '46dc315f262c0d32e2af899f2e653a094997d543aba1d3bed8aebf697d237a8a',
     armv7l: '46dc315f262c0d32e2af899f2e653a094997d543aba1d3bed8aebf697d237a8a',
       i686: '48785793958d45b5ce1e92ea386cdf7b3e39ae4d4622e9fb04db9b64bd9431dc',
     x86_64: 'ee30655620726f03c3880a9efed3eda56e25be47b380ed31e2f3b7d017dec1a2'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
