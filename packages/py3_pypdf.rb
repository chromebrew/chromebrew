require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "5.3.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aa82f9b4b49d81a60062e7ebdd600bc0b4abce6258d318cc9e33202694304339',
     armv7l: 'aa82f9b4b49d81a60062e7ebdd600bc0b4abce6258d318cc9e33202694304339',
       i686: 'fe74a3c5ea5caca22df36703c93a867fb7b8e5c74e1d02e3a0d7b49e6d06bbf9',
     x86_64: '6416a6fc2a58c13909bb21851043223f55d0342bc5e0c5948cdb55d3e1bc26d3'
  })

  depends_on 'python3'

  no_source_build
end
