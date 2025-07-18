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
    aarch64: 'df18f10779c82f90149713a03d33565821f61dc9d38dc548c7d5a5d4c138f766',
     armv7l: 'df18f10779c82f90149713a03d33565821f61dc9d38dc548c7d5a5d4c138f766',
       i686: '6f79482b010cc3827f0a404181fc3cbc02b64dff7ff30ec524840d9332298579',
     x86_64: 'fa30fbf10eea81be37f6f32216dc03da6aea62d44f7006cd6c9274fe58c47439'
  })

  depends_on 'python3' => :build

  no_source_build
end
