require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.65.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a133256350ef98a5b9bc87cc62355c54614ee61da3523fbd5e2f360a64565417',
     armv7l: 'a133256350ef98a5b9bc87cc62355c54614ee61da3523fbd5e2f360a64565417',
       i686: '15037976f01a206b16c14720815b299f66120e2ef5f0d2815d329782db780108',
     x86_64: '94e2f6da494eb3417943b57731937ccf4329bbcfba63b9ff0795df77a112679b'
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
