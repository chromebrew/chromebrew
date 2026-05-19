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
    aarch64: '1d92ce274db7320effc30a9ed3aea34ce21dec41322cfa767669963b1c53bc2f',
     armv7l: '1d92ce274db7320effc30a9ed3aea34ce21dec41322cfa767669963b1c53bc2f',
       i686: '661c47e09a9b77252dede2104bb5d2a14c7481399d59e343acd29c39048d67e9',
     x86_64: '90c4f59452ac65a612c494ec19b754aa740f9c38bdab1b95f142513b66a4f2d0'
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
