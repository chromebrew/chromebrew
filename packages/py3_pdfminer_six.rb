require 'buildsystems/pip'

class Py3_pdfminer_six < Pip
  description 'PDFminer.six is a community maintained fork of PDFminer.'
  homepage 'https://pdfminersix.readthedocs.io/'
  version "20251229-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '57fd948f4b0fd99133af84530ee61258eb676d1cdbbb67c627657a12d2fbfb0c',
     armv7l: '57fd948f4b0fd99133af84530ee61258eb676d1cdbbb67c627657a12d2fbfb0c',
       i686: 'ed0ae1aa82187d6e029b4bc3d44f58844b1f9662a82872c70858793b6cde7c2a',
     x86_64: 'a0c022d6fcea978d6b7929d1b67bab27d82807bcfeb4881e217d9baef4976acd'
  })

  depends_on 'py3_pycryptodome'
  depends_on 'py3_sortedcontainers'
  depends_on 'python3' => :build

  no_source_build
end
