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
       i686: '5e70d85132d36eca7c2fa2edd32e0bb212e182453daf8c2feb8bf2db09de1665',
     x86_64: '2a16ef76ca751c2e222456dc0fd66939252022ed1b32a8dfdbe1ad7ce6ed5493'
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
