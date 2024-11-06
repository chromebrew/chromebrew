# NOTE: Archived upstream

require 'buildsystems/pip'

class Py3_terminaltables < Pip
  description 'Terminaltables generates simple tables in terminals from a nested list of strings.'
  homepage 'https://robpol86.github.io/terminaltables/'
  version "3.1.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a6667a328edc5aa49a63baaecf87748e6bda2320c6a81201fa8ebd9483588db5',
     armv7l: 'a6667a328edc5aa49a63baaecf87748e6bda2320c6a81201fa8ebd9483588db5',
       i686: '5739b3205848f1934a86cf891dc89d08d140819743267426b74ab2b4ee8dc5b6',
     x86_64: '829808aba035b37708a0f6819d95a6b594dee5df28c76d603253381eb23aee17'
  })

  depends_on 'py3_python_dateutil'
  depends_on 'python3' => :build

  no_source_build
end
