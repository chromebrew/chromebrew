require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.67.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '97a8d1bcba7e0fd8d7192400b3339f5ae272a4794406a373a7213f0efd8899b6',
     armv7l: '97a8d1bcba7e0fd8d7192400b3339f5ae272a4794406a373a7213f0efd8899b6',
       i686: '8ba5d88e837e19c7bace0e3ec6d48f6c2f991307436731c0d63a1b92882b673e',
     x86_64: '89c6c82322f2d72dcfc42e41e4d8d180af8cec7e4d9fafa58e84929af7bb306a'
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
