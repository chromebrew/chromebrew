require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.409-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd42ece72f49eaeda8feff4975ec51693ca18d6e422f9af6cf2d892d3aa3035cd',
     armv7l: 'd42ece72f49eaeda8feff4975ec51693ca18d6e422f9af6cf2d892d3aa3035cd',
       i686: '18616289ee775e87e62fa7810121fe40c847d7662a469ab1992d593d606e3e53',
     x86_64: '7b358d90b859749360c45021657c047347f97bd2abff1267efaa7d135b9e690f'
  })

  depends_on 'py3_nodeenv'
  depends_on 'python3' => :logical

  no_source_build
end
