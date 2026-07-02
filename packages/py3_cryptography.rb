require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "49.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a03a75451b80e3c2f6bbc479a6e7aa385eb839a7f50f4990d0b2e20dcd13fc6e',
     armv7l: 'a03a75451b80e3c2f6bbc479a6e7aa385eb839a7f50f4990d0b2e20dcd13fc6e',
       i686: '70cb905bacb2c9ae5a854fc0d7f93551a0dac1763dd50c01b898734c3ec03324',
     x86_64: 'd5da532912f83f076b0ae3e190424a81e30242e8b79882dd216be50bd0497977'
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
