require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.64.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '19ceafea2b2abc9ee286a49e3a045825cdcdf1944a0d48f4fdd101cd9b4c05c6',
     armv7l: '19ceafea2b2abc9ee286a49e3a045825cdcdf1944a0d48f4fdd101cd9b4c05c6',
       i686: 'cb3b242e74931e41d58ef50947e3bfd2b7267324fb392ac07669c646022be7ac',
     x86_64: '89153626fc7eb88e06cd162874090f1e6692e15513bddbc4cd0f0913aeca7c46'
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
