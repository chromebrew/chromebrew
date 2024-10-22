require 'buildsystems/pip'

class Py3_flit_core < Pip
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  version "3.9.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '01401d079f3e80bcc8f1a1b89368b1f6194909b411d9469e834c239fcb5a4e0b',
     armv7l: '01401d079f3e80bcc8f1a1b89368b1f6194909b411d9469e834c239fcb5a4e0b',
       i686: '98509dc8ddd38b49bedd3c6ad13269f82fb00504d332c3067611e8abe900d16c',
     x86_64: '310d593fb5e5c9c994ffcd3de67191c8d42379b7ab5049d3d2f0dc22b9fcf051'
  })

  depends_on 'python3'

  no_source_build
end
