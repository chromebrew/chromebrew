require 'buildsystems/pip'

class Py3_pyopenssl < Pip
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  version "25.0.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d0c7181d4a280f5ebff85be6d3ba9486a1395d33da848f5584eefd5caa91b80',
     armv7l: '7d0c7181d4a280f5ebff85be6d3ba9486a1395d33da848f5584eefd5caa91b80',
       i686: '9bb82837c9dae4f12870e4cb5959e8b6bf4640c03b3f40b5b85c41b833af1834',
     x86_64: '193238dbc97f7a7914d6b45b94656f6fba61cee7e0619228aa4ed5667e5107ef'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
