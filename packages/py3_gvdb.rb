require 'buildsystems/pip'

class Py3_gvdb < Pip
  description 'Python client for GVDB distributed vector database'
  homepage 'https://github.com/JonathanBerhe/gvdb'
  version "0.34.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e67aa346885a8d7bcd37a9d3f8eb5c181ccf4d1cb3dd55e62e0653de7717cb8b',
     armv7l: 'e67aa346885a8d7bcd37a9d3f8eb5c181ccf4d1cb3dd55e62e0653de7717cb8b',
       i686: '1e9267b286df380842eb2fd7694178cd27e9b198997dfda73efce728af51fa9f',
     x86_64: 'a4ba8c9eefc4ccb3d67098fbc1fd772076315e42abe907caf984af5814b6e3b4'
  })

  depends_on 'python3' => :logical

  no_source_build
end
