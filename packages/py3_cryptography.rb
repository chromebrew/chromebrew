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
    aarch64: '4126aa0aa89178a2b4173c7ef9f30e024e98601b48a42b720ff448e88f35848c',
     armv7l: '4126aa0aa89178a2b4173c7ef9f30e024e98601b48a42b720ff448e88f35848c',
       i686: '5a61b352036615d8936ec081df5c506196137e308c0f50de1495cdbd18ffc547',
     x86_64: '0dc9ec491282137937755342171e8586b8d06fbe145cb1bb0ade1b4e54ce3a1d'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'openssl' => :library
  depends_on 'py3_cffi'
  depends_on 'py3_pycparser' => :build
  depends_on 'py3_typing_extensions'
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
