require 'buildsystems/pip'

class Py3_numpy < Pip
  description 'NumPy is the fundamental package for array computing with Python.'
  homepage 'https://numpy.org/'
  version "2.3.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82432f460424ec9aefdffbbe9dcfa3d95ab6f67f1f9fee2867e8b9a68de3a0e9',
     armv7l: '82432f460424ec9aefdffbbe9dcfa3d95ab6f67f1f9fee2867e8b9a68de3a0e9',
       i686: '57468889449ede07629313340d03495637ee90fa946ecd63b15cb0b911dee5f8',
     x86_64: '7f06fed46a33ea664da38211dc80c558f815fc0fd5a91555945f750f31e2cb80'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lapack' => :build
  depends_on 'openblas' # R
  depends_on 'py3_cython' => :build
  depends_on 'py3_setuptools' => :build
  depends_on 'python3' => :build
  depends_on 'zlib' # R

  no_source_build
end
