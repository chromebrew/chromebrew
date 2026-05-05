require 'buildsystems/pip'

class Py3_pyopenssl < Pip
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  version "26.2.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b854900a587ddf8ee2004aad424ef5b51f1abd5d2d1abcc54ee1d4d7cdc0b077',
     armv7l: 'b854900a587ddf8ee2004aad424ef5b51f1abd5d2d1abcc54ee1d4d7cdc0b077',
       i686: '269d7caeff1e089a57dc2254e2cd8acbc427eeb314a6a9a203615b78c741faac',
     x86_64: '2460c7c62b0e452e14e9409c658d2da2d2c450100ad52189c2af5644a88e362a'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
