require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.3.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '604ed6f27f5b57abdb03e9bfb5f6080f1565df7bd484c22f0a4c9bf7d60f5f64',
     armv7l: '604ed6f27f5b57abdb03e9bfb5f6080f1565df7bd484c22f0a4c9bf7d60f5f64',
       i686: '2d24a36e97d2667dc9631ab6e5bac555fd17caf93a928f3fe7b9747a1129ca49',
     x86_64: 'ff71c63c65a798c315dd3d33a9beec0b667718289ee5d6a2d05d4155391835d3'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' # R

  no_source_build
end
