require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.5.5-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5e22886f660b40ae952b2708d712394a34b00edf779140424d5979f6f2606dbd',
     armv7l: '5e22886f660b40ae952b2708d712394a34b00edf779140424d5979f6f2606dbd',
       i686: '5b67b7e7c90a83aca8b37e749519f8a0b0200c5d2e543037a59d5760a71c1c6b',
     x86_64: 'ff05364d01eb67b16f8b2ed8fd93e2359fddc355e09d04f72df78105115233f7'
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
