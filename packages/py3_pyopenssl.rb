require 'buildsystems/pip'

class Py3_pyopenssl < Pip
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  version "25.2.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '646902fb7316240f37a8ddfd41ecc044ef11829ec8ad2e70b762d7f16b5312db',
     armv7l: '646902fb7316240f37a8ddfd41ecc044ef11829ec8ad2e70b762d7f16b5312db',
       i686: '4bcb6f11e0d94b800f4388b230b498144806699797d490218f7c01386f6888f5',
     x86_64: 'e565437f2fc2cf0ea09aa49cad4d29c75f20b9228cc664b2bd78e8b0d247b1d8'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
