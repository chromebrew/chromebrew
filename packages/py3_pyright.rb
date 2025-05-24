require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.401-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a48b9fc60d7ec533f306ee3991ed50611d87fa9a85cbd55a0124b994f5cf757',
     armv7l: '4a48b9fc60d7ec533f306ee3991ed50611d87fa9a85cbd55a0124b994f5cf757',
       i686: 'c112d0bd632c82e8d85184ffb0dbb2de2d638cc79a3f4ec7162e7bf61c4d9727',
     x86_64: '0549e9530c7458518f256032706c21763f8d799e427a09a9663fa68668d7cbf9'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
