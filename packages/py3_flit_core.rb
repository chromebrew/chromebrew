require 'buildsystems/pip'

class Py3_flit_core < Pip
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  version "4.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b8c80fd7aafc48815fcbb3f796efc275f1fe3b46d09e91db43162b5ffa2605fd',
     armv7l: 'b8c80fd7aafc48815fcbb3f796efc275f1fe3b46d09e91db43162b5ffa2605fd',
       i686: 'f29d2ce44fa2be7fbe1e8b4af228c5b66908596a67ed54b9b2127ed99ab7b16b',
     x86_64: '96c58716af11da7e2e437e8cdcd1b2681b94824f2979e62baceeaddb40b3a751'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
