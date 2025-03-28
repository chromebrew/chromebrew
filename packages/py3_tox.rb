require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.25.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '59027e07963e98b65572bdf100fe88402f1e89a9e9ac7d8dac6d75f8a181427b',
     armv7l: '59027e07963e98b65572bdf100fe88402f1e89a9e9ac7d8dac6d75f8a181427b',
       i686: 'edc7a89faacaddc5cc50f220fc89b5f00e1454fa0380a0ab4534f5bc56e92a9a',
     x86_64: '8addf7a196949bfe1519a0a4eeaf04ac503d51e37c8b6b0fbd12c8b5fdf29423'
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
