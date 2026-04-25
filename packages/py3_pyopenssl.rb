require 'buildsystems/pip'

class Py3_pyopenssl < Pip
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  version "26.1.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '234bbc39045e21f82472348c4aed848fb3ed43f0d8804a2a6c80411a3d318503',
     armv7l: '234bbc39045e21f82472348c4aed848fb3ed43f0d8804a2a6c80411a3d318503',
       i686: '0968035435d272b3c8853399d9940fdf809e37cd7a9beb9733eff8db9c0b3d12',
     x86_64: '56365d5429718a18f9588ba9b5b951927136a7e4d560befe5106bb8bd6e3724c'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
