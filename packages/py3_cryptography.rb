require 'buildsystems/pip'

class Py3_cryptography < Pip
  description 'Cryptography provides cryptographic recipes and primitives to Python developers.'
  homepage 'https://cryptography.io/'
  version "44.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0a9ab365df58e161d26aac574d8df5b2d913dbe37d1ef8ec7df0c865a33297c4',
     armv7l: '0a9ab365df58e161d26aac574d8df5b2d913dbe37d1ef8ec7df0c865a33297c4',
       i686: 'cbaadc230213d01d74a747274a94746811a45aa8fd27a5148e43defa95d37b1e',
     x86_64: '0d6b5394083bd0cbb285848bc8fba5c444546b3b7cf3f7c1ecdedf95b25a5a7e'
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
