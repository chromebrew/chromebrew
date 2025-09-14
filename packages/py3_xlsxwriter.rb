require 'buildsystems/pip'

class Py3_xlsxwriter < Pip
  description 'XlsxWriter is a Python module for creating Excel XLSX files.'
  homepage 'https://xlsxwriter.readthedocs.io/'
  version "3.2.7-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd2b868e45ef1513a0dd2c8f7cd58ee74e53e3e7e0791b5fce042747bdbff7f3f',
     armv7l: 'd2b868e45ef1513a0dd2c8f7cd58ee74e53e3e7e0791b5fce042747bdbff7f3f',
       i686: 'e43ae1d3e4bf709316eca84aee1ef408d5390b9b0e9609eda813a2ab538df372',
     x86_64: 'c6140d4fbf486080ae13e7877114b4060d03e8ffe6b5e7427d2d857c375cbb8d'
  })

  depends_on 'python3' => :build

  no_source_build
end
