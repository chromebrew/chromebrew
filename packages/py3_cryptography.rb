require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "44.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9928ba7db813aaab6b32edf19476c3dadc30c2246ae9aa3f9ba03d6c1c86415e',
     armv7l: '9928ba7db813aaab6b32edf19476c3dadc30c2246ae9aa3f9ba03d6c1c86415e',
       i686: '1771cc36986a2d2bb104a91f58ce9928f8520baeaefc295a99cce80c2784d25b',
     x86_64: '153c455492eb85288caea5fc449820a0d25878396fb25daa28ad3d34dc4333ec'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'py3_cffi'
  depends_on 'py3_pycparser' => :build
  depends_on 'py3_typing_extensions'
  depends_on 'rust' => :build

  no_source_build
end
