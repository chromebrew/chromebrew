require 'buildsystems/pip'

class Py3_jeepney < Pip
  description 'Jeepney is a low-level, pure Python DBus protocol wrapper.'
  homepage 'https://gitlab.com/takluyver/jeepney/'
  version "0.9.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd4790dd4cdec8b48628b5db022281b73508f70db49f0cced3fd5d53c153d2325',
     armv7l: 'd4790dd4cdec8b48628b5db022281b73508f70db49f0cced3fd5d53c153d2325',
       i686: '88e3f8305de34d52f0cf790a5ed17e007ab1be7dacaaca83238ff6d4210b9c71',
     x86_64: 'a5c8ecb0b96b57984e0b9d77f35503597b56f0acc6ca649f237f7535ad1ab894'
  })

  depends_on 'python3' => :build

  no_source_build
end
