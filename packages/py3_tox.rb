require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.32.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7dbd473e0e4b26f043f67625dca5c4401ac954cc144d19870261506614c50371',
     armv7l: '7dbd473e0e4b26f043f67625dca5c4401ac954cc144d19870261506614c50371',
       i686: 'a1895ca292fba70d05087d71718f9a2a4a2e7becdc09f4cd656ca54750fa637d',
     x86_64: '46c78013ae65f298f90a032ad23b5891b667432419043713d64715cca61ee3da'
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
