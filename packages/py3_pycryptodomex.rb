require 'package'

class Py3_pycryptodomex < Package
  description 'Pycryptodomex is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  @_ver = '3.10.1'
  version @_ver
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'https://github.com/Legrandin/pycryptodome.git'
  git_hashtag "v#{@_ver}x"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.10.1_armv7l/py3_pycryptodomex-3.10.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.10.1_armv7l/py3_pycryptodomex-3.10.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.10.1_i686/py3_pycryptodomex-3.10.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_pycryptodomex/3.10.1_x86_64/py3_pycryptodomex-3.10.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5e171077d9015b2520ef00e45254e714c793f138de2e73021cc9014ca4c57c2a',
     armv7l: '5e171077d9015b2520ef00e45254e714c793f138de2e73021cc9014ca4c57c2a',
       i686: 'e582907524615c4ee549b2c2a811441a975305db7b24d66e7552f3242c34a603',
     x86_64: '932d34f2810d2a6aeb28a1109fa1a91807babe26eef2593980cb752aee4a5ada'
  })

  depends_on 'py3_setuptools' => :build

  def self.build
    system "python3 setup.py build #{PY3_SETUP_BUILD_OPTIONS}"
  end

  def self.install
    system "python3 setup.py install #{PY_SETUP_INSTALL_OPTIONS}"
  end
end
