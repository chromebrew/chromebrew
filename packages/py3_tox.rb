require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.28.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ccc5615fb7e534388cc845764a492f7d6df2c2ea7bffd36728211d8aa69d7e1c',
     armv7l: 'ccc5615fb7e534388cc845764a492f7d6df2c2ea7bffd36728211d8aa69d7e1c',
       i686: '38f933e4610ec317f26fba2a6d06c161e1eab2f294b17cf6a2c3515b46052d7f',
     x86_64: '86630d24169d03f328a1d7b10096010713ed3a5bd101f9556347670eab0b9333'
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
