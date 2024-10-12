require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.384-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b042215b519fa19a00ba7fa09e0f1a1c3eb7b609d1670eda73664a759ebfce49',
     armv7l: 'b042215b519fa19a00ba7fa09e0f1a1c3eb7b609d1670eda73664a759ebfce49',
       i686: 'c764acbc8e3b8b2d245bd18208071a0a2ac3c4605a780e64f5ab022c7a9f2d31',
     x86_64: 'e7c909794241c67ffd2ca17ad7319f5697d2f478683dc93c6921d2cf6a4b8ed7'
  })

  depends_on 'python3'
  depends_on 'py3_nodeenv'

  no_source_build
end
