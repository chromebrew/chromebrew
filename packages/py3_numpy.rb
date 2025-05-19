require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.2.6-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '631f46a23b7993fb04bc6daef9d89e30658fe243c3d8073246c93365f7888497',
     armv7l: '631f46a23b7993fb04bc6daef9d89e30658fe243c3d8073246c93365f7888497',
       i686: '50cb59cb1bd97d225c5840e20b2a75caefbad9d29b693a02aaa6ccb48199f405',
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
