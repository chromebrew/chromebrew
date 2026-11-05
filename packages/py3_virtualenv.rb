require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.15.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dbff5c6c4fdf7976a8997209aabddf8f55a0d43eaf4ba6d637d3b49d7a859926',
     armv7l: 'dbff5c6c4fdf7976a8997209aabddf8f55a0d43eaf4ba6d637d3b49d7a859926',
       i686: 'd645f648cccce528da9ef93e3e182c121f1f371cb6ee3a675eeb6bc63fe1d330',
     x86_64: '03e14bbc2a99f2452bc00fa381cea31a0741c91b8e89634d095f75d920011cf6'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
