require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.22.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '57d71875a6c39c5f31c8342d8a817a391872d4bc0cab6fb6b0453f4f03cdb93f',
     armv7l: '57d71875a6c39c5f31c8342d8a817a391872d4bc0cab6fb6b0453f4f03cdb93f',
       i686: '0d9edcfd5169595486045b1dde09e326e0f68061514788bea5fd1b2e9f61908a',
     x86_64: '714cb3110dd3ce6dc975753bd3bf12deb123354be1a321349bf5439c96563a04'
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
