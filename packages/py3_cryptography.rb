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
    aarch64: 'b365b1b1ddd6c8c12fa6d154d2e880786e18411e7930f24f1a30beeae14e17ac',
     armv7l: 'b365b1b1ddd6c8c12fa6d154d2e880786e18411e7930f24f1a30beeae14e17ac',
       i686: 'bf01e543f4f432f9bac861e8d4dd25c3178d3f4be0bfcac1be2a9dcecb042cf3',
     x86_64: '03e4a089063008fdf2d73f00226f17947f783693f6892a355903bc1e6711f05f'
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
