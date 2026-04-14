require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.2.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '36fee157202fb1bb42aee12be1ee8db5a7eb0e0d5e8957039b32b9889c58d55b',
     armv7l: '36fee157202fb1bb42aee12be1ee8db5a7eb0e0d5e8957039b32b9889c58d55b',
       i686: '107085a52703802b500deafbdd1597a438a6c45ef2ec166b4d23740538ac68f7',
     x86_64: 'f5303ea7a5028e64ce8cfe017240085fdcb1430d3a899de8d2474c576981e0bd'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
