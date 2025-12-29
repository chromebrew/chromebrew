require 'buildsystems/pip'

class Py3_pdfminer_six < Pip
  description 'PDFminer.six is a community maintained fork of PDFminer.'
  homepage 'https://pdfminersix.readthedocs.io/'
  version "20251228-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f85bf1ad6d3aa3f267276485a8f781b53a3dd10abe81005d21f4dc62c9e008f4',
     armv7l: 'f85bf1ad6d3aa3f267276485a8f781b53a3dd10abe81005d21f4dc62c9e008f4',
       i686: '10ad5fe3450e97ecfeab2768281d251da34a53dc3553302e4f68a04f81834a6d',
     x86_64: '5aecf65d23c2486977151178291d43fcd6a574482319a784de3b0fcd3e087d1d'
  })

  depends_on 'py3_pycryptodome'
  depends_on 'py3_sortedcontainers'
  depends_on 'python3' => :build

  no_source_build
end
