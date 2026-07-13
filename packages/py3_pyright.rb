require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.411-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74acea14283026d867124da3e96c03f66284b2a0afcddbaa22ff373e763bee31',
     armv7l: '74acea14283026d867124da3e96c03f66284b2a0afcddbaa22ff373e763bee31',
       i686: '680dbf0ff243555fb702af45c40e403457f2a729e37efa31a9c4e5d5acdfa1ac',
     x86_64: '543603a52b933895720ce92194935d21e22b8bfd59fc69043a9e77398a54ebd0'
  })

  depends_on 'py3_nodeenv'
  depends_on 'python3' => :logical

  no_source_build
end
