require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.21.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ada51f574629be5335c84b3bb81b22647c15d140cda4ec8046ed77058a484f3',
     armv7l: '9ada51f574629be5335c84b3bb81b22647c15d140cda4ec8046ed77058a484f3',
       i686: 'ef06c5b67f4c5f456bee28dfede9f69a5d532c59addb16b38264926469982e95',
     x86_64: 'a061f3530f5015176dbf89e89d00174085438720e9482ec9d1b2aa5502cb96ce'
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
