require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.26.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4395aa2732921de82b30c5a6cd3cd42eb52a592b7fda69c0c77b60e29a4415d8',
     armv7l: '4395aa2732921de82b30c5a6cd3cd42eb52a592b7fda69c0c77b60e29a4415d8',
       i686: '9b17e3f981cbf30a6834a406412008ac04a3e779f5f67fa28884a0297fd06b29',
     x86_64: '4209972416b437caf2407e9bdfcb9a40d356e6bd3a9b531efeccabea40be3345'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
