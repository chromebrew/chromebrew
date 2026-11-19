require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.15.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb4f44da9c9f6d18d53091ebeeedbc8057c1812dc01adf4b57e98e7274b25d3e',
     armv7l: 'fb4f44da9c9f6d18d53091ebeeedbc8057c1812dc01adf4b57e98e7274b25d3e',
       i686: 'da64195096093726c3c465385f502a0a9d512e0cb4109145337a281dd9990ceb',
     x86_64: '4cf82f11f6926130b8c9e4821fc60e8f45097f5fffefff31a81d58e16449259d'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
