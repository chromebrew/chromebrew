require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.63.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '74f137afc151bdb4003616b83a6f7c5c848307cb4752f2167b3acb5dd49cb80c',
     armv7l: '74f137afc151bdb4003616b83a6f7c5c848307cb4752f2167b3acb5dd49cb80c',
       i686: 'c048359778de41e24177af3bfeef049719c683d25f67cc25c7889452748472f3',
     x86_64: '59b72e6a3cf81147bfc0266f1f1a1c7abccc8e0d8338546be3dd9427f893dff8'
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
