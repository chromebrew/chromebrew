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
    aarch64: '18affd8a7d48e2a5b6d7672a40c5c611e2eecfc59682e504452369222bc8f059',
     armv7l: '18affd8a7d48e2a5b6d7672a40c5c611e2eecfc59682e504452369222bc8f059',
       i686: 'f2ef764fcc0cdcb416f1c941de6111e5dbc2a77f4945520f559f9aa2fb932f3d',
     x86_64: '140d8459fb006daa3c7164d4cbb2ae5371930a923bbb12c276e52dd7ddfbf3ee'
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
