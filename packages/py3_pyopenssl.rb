require 'buildsystems/pip'

class Py3_pyopenssl < Pip
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  version "26.3.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7a3ff7254994775ccdcab09f00ef92fa4c740752d029205902d8f94626b1aff',
     armv7l: 'a7a3ff7254994775ccdcab09f00ef92fa4c740752d029205902d8f94626b1aff',
       i686: '550b8c3dcb588d20024cb46a8500a3906739753546447058d93fa59a4ef3068f',
     x86_64: '4a5662013fb5fb435adf8a09488966f002318967492a43abbba2a65f0014fb04'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
