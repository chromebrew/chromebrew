require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.3.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51dcad5cfe217ba9ebb76084aefc742fd81c183918ddcf744149af6aa010134e',
     armv7l: '51dcad5cfe217ba9ebb76084aefc742fd81c183918ddcf744149af6aa010134e',
       i686: 'e779f6085531615b2c274d6a21abf0f35f3b8092aade7228dfa116d9c3ef915b',
     x86_64: 'b9cb75e98e6c3034e2e12cb52737df769d5324d6427c0c6f49ce100640554e8e'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lapack' => :build
  depends_on 'openblas' # R
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :build
  depends_on 'zlib' # R

  no_source_build
end
