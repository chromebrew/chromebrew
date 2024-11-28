require 'buildsystems/pip'

class Py3_pyopenssl < Pip
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  version "24.3.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c2f6222d2cf3bcf74fb4dd67b597fb0a6ebb6d2a7a65d18c30c0f9efa64f1ce',
     armv7l: '0c2f6222d2cf3bcf74fb4dd67b597fb0a6ebb6d2a7a65d18c30c0f9efa64f1ce',
       i686: 'f632863de0003cd081abf032c75aa07355182bd595950f63d6c10852e339ec79',
     x86_64: '7b2aba1c2ac7073d3911e91f8155fa02264ec44635a521fc029219c46d0e57ae'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
