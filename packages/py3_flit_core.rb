require 'buildsystems/pip'

class Py3_flit_core < Pip
  description 'Flit provides simplified packaging of Python modules—core portions.'
  homepage 'https://flit.pypa.io/'
  version "4.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '47d92fddbbaad1c336fb2d28802bf03362f3eb213bcb8133f26fdea699be9d5f',
     armv7l: '47d92fddbbaad1c336fb2d28802bf03362f3eb213bcb8133f26fdea699be9d5f',
       i686: '2c3b1df1be6865f9f7b54d548327d5cce4034592180c783e6b9b4a5ff2368717',
     x86_64: '78585d7a226e4123ab46574678c5a8c6eab93432dfe28f9c3f06ef258259a786'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
