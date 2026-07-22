require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.58.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '660c5175e3c9dd327eb05a93cf2922dc384a1b49ce544a336a84de51b1f1b9ac',
     armv7l: '660c5175e3c9dd327eb05a93cf2922dc384a1b49ce544a336a84de51b1f1b9ac',
       i686: 'ee5c08874efbc77f19a194c47e7e20f8b60f6c66d12e081c9665d3ccefbdebf8',
     x86_64: '0d5852b5ed17350b4a6d5721f1814c244292312301d9653f6eb1b409eb063d49'
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
