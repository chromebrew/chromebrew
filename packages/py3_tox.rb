require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.56.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd92a3f20af53f0ba173ca3e8245c7b075a1fd9da66a1f95de49ea4e95925dea',
     armv7l: 'dd92a3f20af53f0ba173ca3e8245c7b075a1fd9da66a1f95de49ea4e95925dea',
       i686: 'e199b73852e54d11cdc8a8c69289c95faec16316c07c107fad8fe54d5b12a626',
     x86_64: '9204a6b27dea62d5112875a11956e0bc75e9b7b1616a806fa54211af9b745663'
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
