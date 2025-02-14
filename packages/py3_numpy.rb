require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.2.3-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a465cc7cbd3258d866a7620deb9f1150466ad4bd83627dd38a13d5843dc01584',
     armv7l: 'a465cc7cbd3258d866a7620deb9f1150466ad4bd83627dd38a13d5843dc01584',
       i686: '6c68f4c2d57db9b7dc2085551920d247e5632b7318d492038c9b06a9557717d4',
     x86_64: 'ab97240687c62b7f6ce96f64cc06c1b460d7fd143a65bb3cb181bec0619d21a1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lapack' => :build
  depends_on 'openblas' # R
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :build
  depends_on 'zlib' # R

  pre_configure_options CREW_ENV_OPTIONS.gsub('mold', 'gold')

  no_source_build
end
