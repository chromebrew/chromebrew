require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "7.1.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0c39dbc4ef86b51b5f7a4f37247ca45a3d05e8756c51d862aebcc608973ca879',
     armv7l: '0c39dbc4ef86b51b5f7a4f37247ca45a3d05e8756c51d862aebcc608973ca879',
       i686: '3005e01d678398ea686be3e0efbdfe319f8821d47d7166d99ee801b62c264d62',
     x86_64: '4b637cac948067ec9eb7188f6ffb111b932dd051148f9bcb52cc8b3c4d228802'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
