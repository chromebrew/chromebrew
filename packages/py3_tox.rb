require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.67.13-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '78a2f5828d894966425ef4c1f34123a9608afb57f0c7cd1467db55f5e2c96a7e',
     armv7l: '78a2f5828d894966425ef4c1f34123a9608afb57f0c7cd1467db55f5e2c96a7e',
       i686: 'f57a3253e613dba120d5498e3caf8b66d576b1e45233dd66c92a17621d9390ac',
     x86_64: 'e1cf8b9d00fecb03a6d29e4d3eedd7c7089532907d628c8359953a1656085d2a'
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
