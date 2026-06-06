require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.13.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da65a0df977e44aecbab5c2b5cf7a9fc7b07a2fea18a8c9540449fb91deabc6a',
     armv7l: 'da65a0df977e44aecbab5c2b5cf7a9fc7b07a2fea18a8c9540449fb91deabc6a',
       i686: 'eed6c973068aaca25f2bb61bdad5288a9b8dcd35b82ee41cb36a498eb06ffe23',
     x86_64: '02a67b5d5d2ce9208e586bacebabcb758763d5259b1c2a55e4ebbb5e698ed8e6'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
