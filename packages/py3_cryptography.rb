require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  @_ver = '41.0.5'
  version "#{@_ver}-py3.12"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/41.0.5-py3.12_armv7l/py3_cryptography-41.0.5-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/41.0.5-py3.12_armv7l/py3_cryptography-41.0.5-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/41.0.5-py3.12_i686/py3_cryptography-41.0.5-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_cryptography/41.0.5-py3.12_x86_64/py3_cryptography-41.0.5-py3.12-chromeos-x86_64.tar.zst'
  })
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
