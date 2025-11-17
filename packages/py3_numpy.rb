require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.3.5-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '64a3efd8b98732e3cbe85cd1c9494bef40f8aab379e024661509d1589b38f5ee',
     armv7l: '64a3efd8b98732e3cbe85cd1c9494bef40f8aab379e024661509d1589b38f5ee',
       i686: '515ccf536c3a5d6777a34d9adafcd0790c439ff1b053309abe74f148e34663a2',
     x86_64: '3918dc459a05652d51a72656f4921e802c5704b9e6348a25800820ed92699ae1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lapack' # R
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R

  no_source_build
end
