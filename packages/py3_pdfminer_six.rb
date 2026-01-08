require 'buildsystems/pip'

class Py3_pdfminer_six < Pip
  description 'PDFminer.six is a community maintained fork of PDFminer.'
  homepage 'https://pdfminersix.readthedocs.io/'
  version "20260107-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '122c13a17d44ac598a081df519e418f91302e45d626e5287da06930051bf6daa',
     armv7l: '122c13a17d44ac598a081df519e418f91302e45d626e5287da06930051bf6daa',
       i686: 'e098081ae89b09056f395a5b2ee78d3e51f1267aa01c26fbad2a45067c4d0ac1',
     x86_64: 'b6d341277c157706be961c228acf4b12ae74599f9dd3c073d0a234481fde9b33'
  })

  depends_on 'py3_pycryptodome'
  depends_on 'py3_sortedcontainers'
  depends_on 'python3' => :build

  no_source_build
end
