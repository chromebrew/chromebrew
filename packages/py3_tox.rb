require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.65.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bfaf471b881c2d899f5b3122a7b9fc3a9d4d413d6d1a3797d1e14e52bcd2b4da',
     armv7l: 'bfaf471b881c2d899f5b3122a7b9fc3a9d4d413d6d1a3797d1e14e52bcd2b4da',
       i686: '50cfcb3e4ec232efa0c10c20b6afd9803f00308a8a044d1a56a5b1f6d697e09a',
     x86_64: 'a79b6281db1e1ca98bfcc95ca656e3baf66b88ebc39932c10882715e2d120b05'
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
