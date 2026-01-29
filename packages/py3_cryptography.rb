require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "46.0.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '383d071c270a3a5cb1e937036cf72749bde2891e613e467ed386370b22b95f46',
     armv7l: '383d071c270a3a5cb1e937036cf72749bde2891e613e467ed386370b22b95f46',
       i686: '62616c7ec7f4ade930e4f50527071383d37dde1e2efb18099f28f48ce32b064f',
     x86_64: 'e112d4ef4f001f08dcf6725bae3d80cf7dc4e619cc856f5e192a51b2dd5aaa15'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'py3_cffi'
  depends_on 'py3_pycparser' => :build
  depends_on 'py3_typing_extensions'
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
