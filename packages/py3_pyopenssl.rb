require 'buildsystems/pip'

class Py3_pyopenssl < Pip
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  version "24.2.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ecbf746d6465d5b96a1a80a12597a68018dd5e97cd1ff9a7a6ae96e318e4420f',
     armv7l: 'ecbf746d6465d5b96a1a80a12597a68018dd5e97cd1ff9a7a6ae96e318e4420f',
       i686: '25a91a785492c5700d91107847c649fb8ab0ee173435268d334542628f1e4183',
     x86_64: 'c1a2aafac4a991dbb49b30a4e5346650364fa8f318314ea980cd5f3779f70539'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
