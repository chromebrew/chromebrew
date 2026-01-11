require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.4.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a3b48b1c0193a337bc51ddc35c08fd2fda86e0fc3fb18cf19e5a398a95e017ec',
     armv7l: 'a3b48b1c0193a337bc51ddc35c08fd2fda86e0fc3fb18cf19e5a398a95e017ec',
       i686: '951ca7a8c973fb7292f52bc1c45c2942eff5d4dbc3ef395baa8adaab723475e5',
     x86_64: 'ac20d536d960f516bf56cb595463146983a12256819727ecd74b87d675f78c8d'
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
