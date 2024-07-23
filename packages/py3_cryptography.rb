require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  @_ver = '41.0.5'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '107b0bf0c7535e55026aaf0df8ccdb84ee54a3231e39fadfc7e1b17a4c5c4415',
     armv7l: '107b0bf0c7535e55026aaf0df8ccdb84ee54a3231e39fadfc7e1b17a4c5c4415',
       i686: 'a705bddfc38132bc0262700d4553b8132d83d561bcc4f0351f2f58c64d01db85',
     x86_64: '668cbdd1c91b7b4a49e33a9b940696881a08b3c7188c3b811d662ba66fa82b9b'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'py3_cffi'
  depends_on 'py3_pycparser' => :build
  depends_on 'py3_typing_extensions'
  depends_on 'rust' => :build

  no_compile_needed
end
