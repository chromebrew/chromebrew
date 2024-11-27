require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "44.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9bc2a5a2e7dd7e2a0184247170ea6d0628a8867ae24afa8b31bb40b8dcb14a92',
     armv7l: '9bc2a5a2e7dd7e2a0184247170ea6d0628a8867ae24afa8b31bb40b8dcb14a92',
       i686: 'cbaadc230213d01d74a747274a94746811a45aa8fd27a5148e43defa95d37b1e',
     x86_64: '2547fe2badd2cb280f151e15a09af6fc1911e7e5c5516c44c54c859569bb7ec0'
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
