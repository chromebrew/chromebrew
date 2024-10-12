require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "43.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd24a92598b2dcb716e8c02032c09ce2157ed24a9d355c168e3749c6bebca93f',
     armv7l: 'dd24a92598b2dcb716e8c02032c09ce2157ed24a9d355c168e3749c6bebca93f',
       i686: '49ea54d9de45e3e9643b6eb31cfeccb5c41a73105782fb83a27ac9fa309764ae',
     x86_64: '18e6f6d26190f93b658c533606c378b41c58a97b3fe1c39c0e43e591eb6b9ce9'
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
