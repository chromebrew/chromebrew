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
    aarch64: '27c2792e468a251abc6fe8427ffd809bb235c1e3e5a0e333d24cd441d086ef49',
     armv7l: '27c2792e468a251abc6fe8427ffd809bb235c1e3e5a0e333d24cd441d086ef49',
       i686: '083a522ccbc19f74dbd62561d4e99647e4597529521ed9b639bbd21fdab731e5',
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
