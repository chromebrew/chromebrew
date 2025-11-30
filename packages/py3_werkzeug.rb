require 'buildsystems/pip'

class Py3_werkzeug < Pip
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  version "3.1.4-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c0cfbcbe7e7f7c6fde6c07a7d8c0a6c05e202790fa68cecbaa8aaacf6a680953',
     armv7l: 'c0cfbcbe7e7f7c6fde6c07a7d8c0a6c05e202790fa68cecbaa8aaacf6a680953',
       i686: 'e1787d99e32a96c43c2364aaf42d3eee01f821fe4711a2d0ed98d354b59d5af2',
     x86_64: 'bee743fe097b796bf60fd52664d3e0a8b1f583b5d3f706d9370708d413476982'
  })

  depends_on 'python3' => :build

  no_source_build
end
