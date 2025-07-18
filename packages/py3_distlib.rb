require 'buildsystems/pip'

class Py3_distlib < Pip
  description 'Distlib provides distribution utilities for Python packages.'
  homepage 'https://bitbucket.org/pypa/distlib/'
  version "0.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '477e951d763f800d887f09f51cbaf248e0f249daf5561666b665db526dd313da',
     armv7l: '477e951d763f800d887f09f51cbaf248e0f249daf5561666b665db526dd313da',
       i686: '6f79482b010cc3827f0a404181fc3cbc02b64dff7ff30ec524840d9332298579',
     x86_64: 'f274479201aeded5d0f0e22dfefa47e658ebf0df7a72520ac30f5e40848a7d90'
  })

  depends_on 'python3' => :build

  no_source_build
end
