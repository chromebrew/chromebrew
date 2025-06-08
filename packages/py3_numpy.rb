require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.3.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '631f46a23b7993fb04bc6daef9d89e30658fe243c3d8073246c93365f7888497',
     armv7l: '631f46a23b7993fb04bc6daef9d89e30658fe243c3d8073246c93365f7888497',
       i686: 'e80e8333cf1651844e40f247abe588ca9203b94a929c5659dce6c5824585a606',
     x86_64: '1cce10159330f985720f8b042592a12293c521f5efcdb3c643358a7a2572a9b0'
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
