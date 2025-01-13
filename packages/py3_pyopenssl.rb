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
    aarch64: '2359b8ea0adcb0bd29dded3dbfca2d490ff1792d0d3bdc044f42afd88accbb48',
     armv7l: '2359b8ea0adcb0bd29dded3dbfca2d490ff1792d0d3bdc044f42afd88accbb48',
       i686: '9bb82837c9dae4f12870e4cb5959e8b6bf4640c03b3f40b5b85c41b833af1834',
     x86_64: '8a225d0761d5ec28a4659165193495438cec74d76f79ef1856a6a2f9ce38a3d5'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
