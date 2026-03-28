require 'buildsystems/pip'

class Py3_pyopenssl < Pip
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  version "26.0.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3c3b6d144dd6e0f1c8d61facdc9cd78773906b19f1d4a96a5ffd1e187a16b631',
     armv7l: '3c3b6d144dd6e0f1c8d61facdc9cd78773906b19f1d4a96a5ffd1e187a16b631',
       i686: '369d0ca5afd579acf5c1aa01ca8f7be548efbb34973e4a770c92a4f011b8663c',
     x86_64: 'cefc76a965c46ecc2096d9882e29fdea24ec3603b8f861ebcb360c3a0ead9df2'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
