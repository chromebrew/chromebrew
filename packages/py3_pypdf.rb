require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "5.5.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec754e6c2dbc015d37f828c38ee52ebf982c297742b295fb04b08ab7f3be5c2b',
     armv7l: 'ec754e6c2dbc015d37f828c38ee52ebf982c297742b295fb04b08ab7f3be5c2b',
       i686: 'e4723cfbdeecdf542134b9726bfeb641ddf64fcb2fae41c3ebc766b3efa0fcc3',
     x86_64: 'ba56b0de33a1368a3c910d04af5e724cb09a79076ea675412bf2fa2b58615802'
  })

  depends_on 'python3'

  no_source_build
end
