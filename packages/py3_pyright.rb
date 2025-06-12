require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.402-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7a9a1cf7ffccfc2c22b72d1c18c6c86cc535d1c966c39c2956b9568c02436d3d',
     armv7l: '7a9a1cf7ffccfc2c22b72d1c18c6c86cc535d1c966c39c2956b9568c02436d3d',
       i686: 'd3c265d32182fc6eb739f0d0b23fd3af38b3a342594ddc0ad6446cfb029e30dc',
     x86_64: '0549e9530c7458518f256032706c21763f8d799e427a09a9663fa68668d7cbf9'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
