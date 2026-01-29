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
    aarch64: '86d3e218892bf477b79f8ed0e9038872e362df19964c36ce830dea6e82adab5d',
     armv7l: '86d3e218892bf477b79f8ed0e9038872e362df19964c36ce830dea6e82adab5d',
       i686: '524042a39cf272003a81efe8015b84e81c529e941cadcb9930fec9ddeb28c59a',
     x86_64: '1fed5a089906d0e1b00cebde42e8ca79dc47d12549e99d974a4d0b8d0e89cd80'
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
