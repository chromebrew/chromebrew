require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.55.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '14951c83322be69ee6ffa98a4808d736d7d4bde769499109560e7e11699b5dc2',
     armv7l: '14951c83322be69ee6ffa98a4808d736d7d4bde769499109560e7e11699b5dc2',
       i686: 'e160b754243ecea17bfd4a7335cae87a6e6eba730e3ac6a9377c05f5a26bb07d',
     x86_64: 'cfedb0e402cd593d8397de099990dadcd8c09a8a4eb66d2c2f3f80abfac000c5'
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
