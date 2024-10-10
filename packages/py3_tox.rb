require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.21.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'db1154ad1193bf88be9e3766c90e0db222816cb4f5e673ca94639ae196ed78b4',
     armv7l: 'db1154ad1193bf88be9e3766c90e0db222816cb4f5e673ca94639ae196ed78b4',
       i686: '45a1cbec61868011483772f6deafe7c93c16d93ec0fcdcf575c44c8bf47ae957',
     x86_64: '8287c44715c6fe5a50fe622a7f5993bca76d0924110392908b75a5e65233653c'
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
