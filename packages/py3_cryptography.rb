require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "46.0.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f7f962af7cbc257746258ed7327660e250ddb4c6034365b7b973186df1428d92',
     armv7l: 'f7f962af7cbc257746258ed7327660e250ddb4c6034365b7b973186df1428d92',
       i686: '524042a39cf272003a81efe8015b84e81c529e941cadcb9930fec9ddeb28c59a',
     x86_64: '3188413706a30f059d15c4fee43a7b5fd965b3b38a4bd0f1e3a576269d6389a7'
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
