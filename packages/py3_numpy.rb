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
    aarch64: '6b10c502c54bd781766b35d77d22e7c82788e9f001d799739a83a929c5ab2de2',
     armv7l: '6b10c502c54bd781766b35d77d22e7c82788e9f001d799739a83a929c5ab2de2',
       i686: 'e80e8333cf1651844e40f247abe588ca9203b94a929c5659dce6c5824585a606',
     x86_64: '903e030e9691808610b3d8e130eef07d4415ac925859afe6be421583c139e4e8'
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
