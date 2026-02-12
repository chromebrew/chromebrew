require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.4.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dbecb8b550e13111d2441f8272ebfe803c451386b0cb6bedb9deb5c694942bca',
     armv7l: 'dbecb8b550e13111d2441f8272ebfe803c451386b0cb6bedb9deb5c694942bca',
       i686: 'e6c2d8105e18b3b144213279a125b764257e718e20f8590c0596b5d22e0a852a',
     x86_64: 'c30c3a4b13c614d7b556b90247e26360a5ded77d43e69abf730b68e05bd3c5d7'
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
