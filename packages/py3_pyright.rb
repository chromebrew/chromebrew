require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.406-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8a739aa40d87be726e3c9e4bda6067bf52c5468bd76fb670280ebdeb3d199aa6',
     armv7l: '8a739aa40d87be726e3c9e4bda6067bf52c5468bd76fb670280ebdeb3d199aa6',
       i686: '6c940dd7656d2508de4305c7cb906baf41bed1a537f2514ea09d6261ca886236',
     x86_64: '9630728a9f66d2d3ee5a62139d072148a6b039ed5d7b3fdbc85caebc5fb3906f'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
