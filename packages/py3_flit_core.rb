require 'buildsystems/pip'

class Py3_flit_core < Pip
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  version "3.12.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd57726707c1c2840143f7eb5295832657100d03cbd84ac93c48234b20076f1c5',
     armv7l: 'd57726707c1c2840143f7eb5295832657100d03cbd84ac93c48234b20076f1c5',
       i686: '54d9413037208c56f7af181b97ab2fe6c105c9e45a26ff0791625c79f7e2be1d',
     x86_64: '8b45699226c2115067c904858e135e095e663626e38e3673994f005fa0c4fd82'
  })

  depends_on 'python3'

  no_source_build
end
