require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "5.6.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec754e6c2dbc015d37f828c38ee52ebf982c297742b295fb04b08ab7f3be5c2b',
     armv7l: 'ec754e6c2dbc015d37f828c38ee52ebf982c297742b295fb04b08ab7f3be5c2b',
       i686: '34449603e2f6fb980bcf4cedde9edd50637b4ceca454e7b6e8e2302bc7a9141c',
     x86_64: '9b627a16ab08a3e04ba68d6721ac1ace3dcde06948b69cc8d1f8a1ac64b75913'
  })

  depends_on 'python3'

  no_source_build
end
