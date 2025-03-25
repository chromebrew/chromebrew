require 'buildsystems/pip'

class Py3_docx2txt < Pip
  description 'Docx2txt is a pure python based utility to extract text and images from docx files.'
  homepage 'https://github.com/ankushshah89/python-docx2txt/'
  version "0.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e23497f15f6d2b3065eb703b731e2c9d0716a4b7d12cbcafd3792d85b35e69fa',
     armv7l: 'e23497f15f6d2b3065eb703b731e2c9d0716a4b7d12cbcafd3792d85b35e69fa',
       i686: '78381058a584d8ae9ba2c33a50765bc54f7763bd155bab8a9bf16b7c366e208d',
     x86_64: 'daafc407e3d8c43de36e90956280b545a2644f07ba0635bf0da392cd1fb5295d'
  })

  depends_on 'python3' => :build

  no_source_build
end
