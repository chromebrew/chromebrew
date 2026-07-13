require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.5.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8369d6193242e9dcc666cb7116cdc46720cfebe2de535be900474c479d691bce',
     armv7l: '8369d6193242e9dcc666cb7116cdc46720cfebe2de535be900474c479d691bce',
       i686: 'c2ac42c2676aaed95ee3a75f9bba3baa11511c48f5be7c6b1b344bc629f4c505',
     x86_64: 'd47a14ecd4685380cea133462f9810f72adda83d67a68ceaf55414161e396dfd'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'lapack' => :library
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :logical
  depends_on 'zlib' => :library

  no_source_build
end
