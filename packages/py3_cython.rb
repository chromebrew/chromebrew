require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.2.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0702b906a2697d9be043635a7b0317ba071572e7e265d4fc95dd2db2cd6e2dd7',
     armv7l: '0702b906a2697d9be043635a7b0317ba071572e7e265d4fc95dd2db2cd6e2dd7',
       i686: '2280f346ea97f3ed16d31ae183d85b36b954a4b81e9ce07b588d378272b19032',
     x86_64: '6873cb8989b669d4ecdda645e7e3e0ba7ed9cf9e26e19d86cfb488d8adb5d9a7'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
