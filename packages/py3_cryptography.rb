require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "44.0.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f0481f054cfbd70b24a6d5ceee94b58fd21fedb06bc416f6567a71bc539eb8b',
     armv7l: '4f0481f054cfbd70b24a6d5ceee94b58fd21fedb06bc416f6567a71bc539eb8b',
       i686: 'bf01e543f4f432f9bac861e8d4dd25c3178d3f4be0bfcac1be2a9dcecb042cf3',
     x86_64: 'cf4f9d61e0a015f54a256cef9dc8160b5bcd86d45a1cf145a6dced771400bdb8'
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
