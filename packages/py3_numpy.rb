require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.4.4-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f6321734906b563c80d321364e2514ac6efd489336a90c710aa7d12adbc3bc1e',
     armv7l: 'f6321734906b563c80d321364e2514ac6efd489336a90c710aa7d12adbc3bc1e',
       i686: '2ff23cc2cf1b8f8419e5875c7c8448af0dbb9f4611fa538e0a96a7710a9f3d85',
     x86_64: 'a3a5cc32d536bddd363c3310f488325b477931d0d386ddca16e43df8c5665272'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'lapack' => :library
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :logical
  depends_on 'zlib' => :library

  no_source_build
end
