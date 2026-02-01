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
    aarch64: '1f9963dbb00dbccd3ce077d81f21d9dc715d1fd5b6ee50b933c0bfde73e8c395',
     armv7l: '1f9963dbb00dbccd3ce077d81f21d9dc715d1fd5b6ee50b933c0bfde73e8c395',
       i686: 'd9da69118b0d44401148ad8728ef44a7e5f73f73822a50f8d5b2d707a73d33a3',
     x86_64: '4f0ea01f630cce62afce90033ea53c440531ecd9f582703b11f33b4d61243033'
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
