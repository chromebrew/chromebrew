require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.7.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e23c1ad7e8df31d19c0b140d93fecb2d8a28041880e9085b3c599985ae025e84',
     armv7l: 'e23c1ad7e8df31d19c0b140d93fecb2d8a28041880e9085b3c599985ae025e84',
       i686: '80efde0b534634222139d66ea33f77b26043956397c645fcde46cc3b45a9887f',
     x86_64: '09b98bf7a38ab3d661b9f83763f3d5073b9e8a826e121427d44202080812f011'
  })

  depends_on 'python3'

  no_source_build
end
