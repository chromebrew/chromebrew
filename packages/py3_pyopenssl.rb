require 'buildsystems/pip'

class Py3_pyopenssl < Pip
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  version "25.3.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '60230a4181f377f8ea0f5a25836b7e10228aa57e68f83191f2afff2779c4296a',
     armv7l: '60230a4181f377f8ea0f5a25836b7e10228aa57e68f83191f2afff2779c4296a',
       i686: '819dc6285660c65f62cb2a4a35ef8413d015bbfddc97fe9032df75c0495fe2d5',
     x86_64: '18110e6e29e4e8ea1694f5d714ac86e0a62688e693c0535a5e8345a034ee541b'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
