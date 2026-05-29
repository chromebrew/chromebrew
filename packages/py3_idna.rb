require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version "3.17-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '249a24a8901128d3d1651bcf14dc3145c5fa76bbd71e0e1755f6d983b79a65fe',
     armv7l: '249a24a8901128d3d1651bcf14dc3145c5fa76bbd71e0e1755f6d983b79a65fe',
       i686: '0822025dda846dd250ada6e83355d1b0b150c7b321e577e0d09dee820d210893',
     x86_64: 'def84787d4754ac4a5064e1a6f1c4753a49c21c93b62f7d48d823f641e362b41'
  })

  depends_on 'python3' => :logical

  no_source_build
end
