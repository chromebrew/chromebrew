require 'buildsystems/pip'

class Py3_snowballstemmer < Pip
  description 'Snowball stemming library collection for Python'
  homepage 'https://snowballstem.org'
  version "3.0.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c9edbdaca8e496423fce53d364c135f6cbc5ed1b183056df328d95ef13395930',
     armv7l: 'c9edbdaca8e496423fce53d364c135f6cbc5ed1b183056df328d95ef13395930',
       i686: '916593f1078d5791fd4cc3e6d19873e4f14940e0513936b2c2eb031adebf72ee',
     x86_64: '6dc31dbc2cf4daccf953f34b3c00a43fd1edf478a6df9c2d969fe98b8b012c57'
  })

  depends_on 'py3_pystemmer'
  depends_on 'python3'

  no_source_build
end
