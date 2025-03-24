require 'buildsystems/pip'

class Py3_pdfminer_six < Pip
  description 'PDFminer.six is a community maintained fork of PDFminer.'
  homepage 'https://pdfminersix.readthedocs.io/'
  version "20250324-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd1c10870a6df183cd20330bda2881d79a3c558730c75890c135c1e05ff4b9734',
     armv7l: 'd1c10870a6df183cd20330bda2881d79a3c558730c75890c135c1e05ff4b9734',
       i686: '7e344fe086e6e56b28e1c6104354fc154398f8260b8f955b53345350e1644cf8',
     x86_64: '453edf695ef46a720fd723ff2d45b8394a858d7ca0df07961bd20d293f3137ad'
  })

  depends_on 'py3_pycryptodome'
  depends_on 'py3_sortedcontainers'
  depends_on 'python3' => :build

  no_source_build
end
