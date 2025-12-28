require 'buildsystems/pip'

class Py3_leather < Pip
  description 'Leather is a fast, approximate chart generator in Python.'
  homepage 'https://leather.readthedocs.io/'
  version "0.4.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21ecce037c7c67b904865cd24cb71769a0054916366763936d1701c2ea1070c0',
     armv7l: '21ecce037c7c67b904865cd24cb71769a0054916366763936d1701c2ea1070c0',
       i686: '010948ba0fb60fc2a625afc570297750f878a4cf8681c1a4e40a2c4c8ebfc903',
     x86_64: 'd2697af53e579c503beb0f9484266afcbdd3032cf6275d23ff2ee2efc7a27847'
  })

  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
