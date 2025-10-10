require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.31.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '55f6133c8667b6cc4ed865206c1d06ae58b3aaee5c57580e36fe697a776ac13f',
     armv7l: '55f6133c8667b6cc4ed865206c1d06ae58b3aaee5c57580e36fe697a776ac13f',
       i686: 'c580aee81bbcdf91e06b61c680f247d3bb4ca00d6fd5155cc3b954579baf8eba',
     x86_64: '0c54ac631270ad82ef800ab52d8ea2ff856afe8944d3d68d3e6b040a20d49f70'
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
