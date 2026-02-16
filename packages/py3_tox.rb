require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.36.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fbf8a20d776c26319e67b5be3d3bb2dfadd5faaaf61444460d60dda7fdd0ca79',
     armv7l: 'fbf8a20d776c26319e67b5be3d3bb2dfadd5faaaf61444460d60dda7fdd0ca79',
       i686: 'faedabc8bd6ab4b4a10d84760ff44d31a90c937036cf70c230131166c37305b6',
     x86_64: '1316a60ff22725b20974ea3ec6cf3f299da926d985ac5284c216ebc69474a3b4'
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
