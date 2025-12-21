require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.4.0-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '486ac0bc085dfbcec5316fba9eb8ad1563157a58f46d344cc781a0183df52607',
     armv7l: '486ac0bc085dfbcec5316fba9eb8ad1563157a58f46d344cc781a0183df52607',
       i686: '6c8a4a1d7ffc60bde2efe841070ba2f7ddcb9ea389037430ffae7c42fa5506c2',
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
