require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.56.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d6a9bd39c3b95a4538b606a28de68b3a1c84103037c96c7f7e21dbbcb95d10d',
     armv7l: '4d6a9bd39c3b95a4538b606a28de68b3a1c84103037c96c7f7e21dbbcb95d10d',
       i686: '36a97750505edb99106da0dbc9fe1efff8d9af6a728474f14b55afd3bb5587be',
     x86_64: '7df4b3b48630c971e9b5ff2afc57c4ae2423352042cdf3ef742ac8591c09fe39'
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
