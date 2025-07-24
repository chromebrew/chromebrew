require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.28.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '55f17cc9da95c141eaed1498e1d6cb971aaf7ebeee913d034d4e92d3bf7f73f7',
     armv7l: '55f17cc9da95c141eaed1498e1d6cb971aaf7ebeee913d034d4e92d3bf7f73f7',
       i686: 'f1e8f2aba0460c378f7ea0151b81e31476d3faf346bdf59877b6599a806912a2',
     x86_64: 'd1722f00e7080a97c092832e2cb730e19e8bdcc4282d85299ab84ea3f74424b0'
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
