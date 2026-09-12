require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.18.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b3ee1d461e52dc0aab34938c580e6ed1b48d19960db30758db6cc9851c7ce6ad',
     armv7l: 'b3ee1d461e52dc0aab34938c580e6ed1b48d19960db30758db6cc9851c7ce6ad',
       i686: 'd050080767115be14d24d1218ff15fe2007638c9bd64dc23d45bdb32f02b9710',
     x86_64: '2d7c5e67dfc0b485ffe803386b39c89f7bed148fad7f267633c6e6382ad593ae'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
