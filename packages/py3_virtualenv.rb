require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.33.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bfc3679977fd63787ea2f4de29fa2443c6591955ae9c710ff66da2ec3f0b68f0',
     armv7l: 'bfc3679977fd63787ea2f4de29fa2443c6591955ae9c710ff66da2ec3f0b68f0',
       i686: 'a5cc7d4b8dc0c5906394625c37522c550c4006390d76abf47439c1b5bedc30da',
     x86_64: 'b80bcad124b932dd301d2f83c976fa5ab7b3821a1350139855fd4159e2d93676'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
