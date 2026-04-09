require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "46.0.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b464e163b2618a13eabc818afb209e2159d77aa4b06b3505bad1f526c6bef152',
     armv7l: 'b464e163b2618a13eabc818afb209e2159d77aa4b06b3505bad1f526c6bef152',
       i686: '76b2a0368c67b19e318b93fab91739bdc5e3cbe37e7451392e440fefb1808b77',
     x86_64: 'c1f7017b646886a3fd5ad446ef9e34c7f3f0ca439f4ba22fae80a0d87a6889fb'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'openssl' => :library
  depends_on 'py3_cffi'
  depends_on 'py3_pycparser' => :build
  depends_on 'py3_typing_extensions'
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
