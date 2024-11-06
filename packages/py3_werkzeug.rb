require 'buildsystems/pip'

class Py3_werkzeug < Pip
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  version "3.1.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd14d8a90118a712dd20281d32e361247a590e4c7eb22f7eab5335d81d34c3e1b',
     armv7l: 'd14d8a90118a712dd20281d32e361247a590e4c7eb22f7eab5335d81d34c3e1b',
       i686: '01ead243345a42b1fa65cfc19d83fbef3851cf7e25aed44bde6761d6f137517c',
     x86_64: '74be366bb065034915b40432ca444b600a09e983876e5fa209513b1da8eba614'
  })

  depends_on 'python3' => :build

  no_source_build
end
