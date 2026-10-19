require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.67.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7a78f7ce879617218232c58fa6403281c7e86fcba05970f8d7160461d54ea411',
     armv7l: '7a78f7ce879617218232c58fa6403281c7e86fcba05970f8d7160461d54ea411',
       i686: '3fca161900e4f085bfb598e9331732f855bfc19e3582a58862f78df4a70eaa89',
     x86_64: '83cc508506da5342fc9e1b34b86c9817cdcc9ff61e9d2cc9a5048539589f757f'
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
