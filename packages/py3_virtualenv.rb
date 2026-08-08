require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.7.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '53ce260842a964e811a6adda77429ece3f42587124643c4bb04a83ea657dcb94',
     armv7l: '53ce260842a964e811a6adda77429ece3f42587124643c4bb04a83ea657dcb94',
       i686: '4ccc8130cd5b248ae6860b7315e6b9378f226c89f18ede5cda5e367e8e4984f8',
     x86_64: '3aff877a8fbd737ce77ad5083df1c9509597e844ace152dd30108de91d41f984'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
