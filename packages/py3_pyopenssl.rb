require 'buildsystems/pip'

class Py3_pyopenssl < Pip
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  version "25.1.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2359b8ea0adcb0bd29dded3dbfca2d490ff1792d0d3bdc044f42afd88accbb48',
     armv7l: '2359b8ea0adcb0bd29dded3dbfca2d490ff1792d0d3bdc044f42afd88accbb48',
       i686: 'f7d565a164ba1830e6232b5b1c15ac9de2fca288a9105e134c1cccc01fd1acaa',
     x86_64: '57f4fe7a5d50c951fb36cb0785754127093e863fe81c4daef7365dea04c7ba01'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
