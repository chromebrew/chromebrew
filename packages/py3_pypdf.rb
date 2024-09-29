require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "5.0.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9f28ba29251c57b9245689859825faa80b67d4d3c3ecfd69bd6be749938f982e',
     armv7l: '9f28ba29251c57b9245689859825faa80b67d4d3c3ecfd69bd6be749938f982e',
       i686: '1db339f8261e0e0d75858cb3fdc227528a06ed28e07ed6216024d5863381ca60',
     x86_64: 'badd57c7afe189b20c07e481bf79a33c64419c111fd29405f2b752b1936ffff5'
  })

  depends_on 'python3'

  no_source_build
end
