require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.400-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4a48b9fc60d7ec533f306ee3991ed50611d87fa9a85cbd55a0124b994f5cf757',
     armv7l: '4a48b9fc60d7ec533f306ee3991ed50611d87fa9a85cbd55a0124b994f5cf757',
       i686: '7d966a0819f31c89cb6ac977937511b86f7327351ccfccfcf5a1d694642b492f',
     x86_64: '6c10b66e7b58f6652e0bfe9b1f199445df62b8b940b77535d6820238a825db7d'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
