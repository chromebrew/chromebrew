require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.67.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b625533c100eba4622b0d7738094b8b2fe07398fef86ff2c69e4e8a7c6dea25f',
     armv7l: 'b625533c100eba4622b0d7738094b8b2fe07398fef86ff2c69e4e8a7c6dea25f',
       i686: '9fddf50f5e6b14cf191e79c5410e9baaaafd20fd6bd7567fc4c61e5b29f05b1f',
     x86_64: 'ac94885ac584f0e3d603c36ce8c3466e804cd8ece5ee71c703afc77cd23b22e8'
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
