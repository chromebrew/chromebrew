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
    aarch64: '4a52cb346ccde837c3838c1071a830ace274b26613d31e8f9bcc5fa1b117fd0f',
     armv7l: '4a52cb346ccde837c3838c1071a830ace274b26613d31e8f9bcc5fa1b117fd0f',
       i686: '75f854fe3849adcd1d84e9bb6388b5bf40651b87372b7c65aec8e3166a9d48b5',
     x86_64: '76bb9dd701933544003ba30233b61e4f61e12696e0c8ee8ca8da4ff2765f9ac9'
  })

  depends_on 'py3_pycryptodome'
  depends_on 'py3_sortedcontainers'
  depends_on 'python3' => :build

  no_source_build
end
