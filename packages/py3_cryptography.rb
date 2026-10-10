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
    aarch64: '0cf21c3405c081265e38e0bee90117ef436634760b451742b177c2d07d2479d7',
     armv7l: '0cf21c3405c081265e38e0bee90117ef436634760b451742b177c2d07d2479d7',
       i686: '73eec019836b13ca8125fb803fd9e0ef7f7244b8dcc6badf54d13f4345d2371f',
     x86_64: '05626bca9f31e4ac94c035ee3790b9642185de5624a1b284b5cc1a8fd79a4cfb'
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
