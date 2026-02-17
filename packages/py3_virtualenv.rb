require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.37.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '58c23f8f7eefff7148724a33c5a8884bad0724340312b4efdac1353f1f254c44',
     armv7l: '58c23f8f7eefff7148724a33c5a8884bad0724340312b4efdac1353f1f254c44',
       i686: '7b2df45a50b2c7967cf1c360c19640fd520bbd7b495d5cf88d39912cd249af5f',
     x86_64: 'bb89c374df06af8ded0bad7aaf2a4d9665278452875e0ef1bb526cebc9e8dd59'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
