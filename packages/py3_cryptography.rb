require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "50.0.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '27be4bc6cfc18ebb1bb7bec049ef8e2ea0112af1914542e7042c6eb7d4f69fb6',
     armv7l: '27be4bc6cfc18ebb1bb7bec049ef8e2ea0112af1914542e7042c6eb7d4f69fb6',
       i686: '15e1ce3af47058c7a9bc49abd61ef45b60ff9b3c2fbcdbc8168decbee6ab60d6',
     x86_64: '0341372ad54603e1f6f440106abff1e72722bd5045633b83281cd696fcddb931'
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
