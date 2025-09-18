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
    aarch64: 'e4ec7a133ba6b5f283076806c429ed9ac3608f454d0d35cdf2cbb907acf3d0b2',
     armv7l: 'e4ec7a133ba6b5f283076806c429ed9ac3608f454d0d35cdf2cbb907acf3d0b2',
       i686: 'e947088526f5de98a760d4957dbbada8ad41ad84738b4446e2f468ffd850c469',
     x86_64: '5471ef1d314992a74b35a7ba2055ced7e2458a9869ae3a9aa4d1556123edb9af'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
