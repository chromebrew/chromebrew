require 'buildsystems/pip'

class Py3_pyright < Pip
  description 'Static Type Checker for Python'
  homepage 'https://github.com/microsoft/pyright'
  version "1.1.413-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1095ad2d06ba297e7a0e950351804cd59b07dbd1226dd1a070d4eec7008dbf36',
     armv7l: '1095ad2d06ba297e7a0e950351804cd59b07dbd1226dd1a070d4eec7008dbf36',
       i686: 'a6c349fd857237774e6e3cee48e9fffcc6769dae4e7e04fc4e1fd39846f33786',
     x86_64: 'be3d8df61f7f0bc46b72cb7026cebee1fdeb69e9b5c8d4181b658302cf00845c'
  })

  depends_on 'py3_nodeenv'
  depends_on 'python3' => :logical

  no_source_build
end
