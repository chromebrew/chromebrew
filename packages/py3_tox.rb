require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.21.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b77fb51fe7dcaebf0cfd49cd9dafa1315ee8fcae2c223a83898448174c81b25b',
     armv7l: 'b77fb51fe7dcaebf0cfd49cd9dafa1315ee8fcae2c223a83898448174c81b25b',
       i686: '07f1a2b938778588ebd444d7cfd1a9679783c3dd4c195ace30dc56c57ddbf7ce',
     x86_64: '752b09efdf95fb7d1fda9d638b78216f715886b62b48eea8db531f609a27507b'
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
