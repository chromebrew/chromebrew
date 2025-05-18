require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "45.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95bced5388c4f5e09d96c4597c79a52ec653505d4097015401d716cad5739d4b',
     armv7l: '95bced5388c4f5e09d96c4597c79a52ec653505d4097015401d716cad5739d4b',
       i686: '349d729a1b1b3c65e020dabd531200964343f2cf50898d7ad6ee81a871aff046',
     x86_64: '68551f4563fc6312cfc33b0488c587357ecffc65ebe409dc380b918aa43284fc'
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
