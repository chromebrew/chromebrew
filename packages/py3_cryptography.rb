require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "50.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '12e5db25eac7ee5739918e327c3b175f7129022719fe0d2ac6e0e45747f54636',
     armv7l: '12e5db25eac7ee5739918e327c3b175f7129022719fe0d2ac6e0e45747f54636',
       i686: '2eca7eaaa37d2b8081d69d3de35048129345471deab76751d3cf2df3d63410a1',
     x86_64: '7530ab21bd5bf3afebf721aa634fdc3f3d3cd35691cb6f35682d4082077883b6'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library
  depends_on 'py3_cffi' => :library
  depends_on 'py3_pycparser' => :build
  depends_on 'py3_typing_extensions' => :library
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
