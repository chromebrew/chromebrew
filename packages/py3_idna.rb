require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version "3.20-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '27f4392488cbdb3e4746eece826c9a9d647f12e1abfbd76b731b13f2cb31dcc4',
     armv7l: '27f4392488cbdb3e4746eece826c9a9d647f12e1abfbd76b731b13f2cb31dcc4',
       i686: '7607554db8df4a07f408facc77a4877b9e2465200ac739d9473139d05d3cd569',
     x86_64: 'cafd93822231b0dc33e98fb42792939d3afc91191b49b646f6f3f3fc3794f3e5'
  })

  depends_on 'python3' => :logical

  no_source_build
end
