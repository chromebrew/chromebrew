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
    aarch64: '740857e0968824a85a03a21488ca0ccf15207fbf5a16cbce627d621f93191474',
     armv7l: '740857e0968824a85a03a21488ca0ccf15207fbf5a16cbce627d621f93191474',
       i686: '7e344fe086e6e56b28e1c6104354fc154398f8260b8f955b53345350e1644cf8',
     x86_64: '0f1ffa38ebf2f2de180b2cc0c087d1c4e0c25bd7e39fbf5cef3f7f62b00950ad'
  })

  depends_on 'py3_pycryptodome'
  depends_on 'py3_sortedcontainers'
  depends_on 'python3' => :build

  no_source_build
end
