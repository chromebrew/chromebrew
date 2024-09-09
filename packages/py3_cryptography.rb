require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version '43.0.1-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b1f0e4321cf8cb114a591ab14612d21f38ed3a3884e9af8d7e110378ae5dd1f0',
     armv7l: 'b1f0e4321cf8cb114a591ab14612d21f38ed3a3884e9af8d7e110378ae5dd1f0',
       i686: '4caa722a093ff2a40bd6b20f8d917c26464df6ec5562930548df044535066a35',
     x86_64: '322f4fc9b4fb79ccf177e614500e51a3dbb32f4b0061ffa314ccec2ca53c5033'
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
