require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.23.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '110056a43d2f55ce385e4dab49b1c8994782de84d442516432bfc817f54bdb47',
     armv7l: '110056a43d2f55ce385e4dab49b1c8994782de84d442516432bfc817f54bdb47',
       i686: 'fd9bbfe266c952307e620f627882dc969d3903d3d7bfea63597692e2ce500796',
     x86_64: '5376cdfa85c7ad561818495b5d3f431729cc5db9b1ceead27c26a1f84122a8a1'
  })

  depends_on 'py3_py'
  depends_on 'py3_filelock'
  depends_on 'py3_six'
  depends_on 'py3_packaging'
  depends_on 'py3_virtualenv'
  depends_on 'py3_pluggy'
  depends_on 'py3_toml'
  depends_on 'python3' => :build

  no_source_build
end
