require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.29.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '62f8b57e1ac160f2bd919e67167440de40a24335263f7b80a28b339d49b776ce',
     armv7l: '62f8b57e1ac160f2bd919e67167440de40a24335263f7b80a28b339d49b776ce',
       i686: '1d764eac5a10786add0750c2e525fc27b7674c4ab6f04f0e9d0cac2869ec12fe',
     x86_64: 'c554515574e667cd4ed2856dd65f0d87e8aa2316a83c5b7fc0db696139a386e0'
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
