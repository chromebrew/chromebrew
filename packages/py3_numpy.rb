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
    aarch64: 'a9cda12b706bb74c7fddf02982b738d13be0d25ebdbf8f2172c3ae7fe52aba37',
     armv7l: 'a9cda12b706bb74c7fddf02982b738d13be0d25ebdbf8f2172c3ae7fe52aba37',
       i686: 'e80e8333cf1651844e40f247abe588ca9203b94a929c5659dce6c5824585a606',
     x86_64: 'a52a6398cf149cdbbad19c65954c502e321b2fadd0151a6f947fc972953a7755'
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
