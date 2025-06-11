require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "45.0.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f4641d6694876131f889720825b613a401564353d161b81fd92efeaa82257601',
     armv7l: 'f4641d6694876131f889720825b613a401564353d161b81fd92efeaa82257601',
       i686: '31d3ce4882c67dcc71da43d349dea53ce7e91fa4ee4e6974e7718b6459281476',
     x86_64: 'e338b3a301b409c5fd50d7bcad1d2c0d63e166c37b371555a0b8014435e424e4'
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
