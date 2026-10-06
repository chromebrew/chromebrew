require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.64.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1bc5b93f05e58369333d3a6d88423b10205e03cfa3b5632cf6cfd3d80a7bce6c',
     armv7l: '1bc5b93f05e58369333d3a6d88423b10205e03cfa3b5632cf6cfd3d80a7bce6c',
       i686: '81e5f58600b855d812660006db91bc559c9de53f6b84c5843da53a9f1ed8d474',
     x86_64: '80cb87cad81dedc32451c81d4fc87e2924a0dda009c9c369d0eb499bf283a13a'
  })

  depends_on 'py3_filelock'
  depends_on 'py3_packaging'
  depends_on 'py3_pluggy'
  depends_on 'py3_py'
  depends_on 'py3_six'
  depends_on 'py3_toml'
  depends_on 'py3_virtualenv'
  depends_on 'python3' => :logical

  no_source_build
end
