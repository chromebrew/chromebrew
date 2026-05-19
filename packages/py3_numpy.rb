require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.4.6-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7ecd9b4658100425acd703d1f1e9afffa153d7eddee9cb622935b34b1440c5c6',
     armv7l: '7ecd9b4658100425acd703d1f1e9afffa153d7eddee9cb622935b34b1440c5c6',
       i686: '11d46942056d6091c874c4e41d3b36b6feaaaab32e8cf21df06d3c10a95bd760',
     x86_64: 'b3cc0558ff0048a1055756094318d0be444c7d2589924ceaccb86804f1c542dc'
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
