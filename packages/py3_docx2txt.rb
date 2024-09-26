require 'buildsystems/pip'

class Py3_docx2txt < Pip
  description 'Docx2txt is a pure python based utility to extract text and images from docx files.'
  homepage 'https://github.com/ankushshah89/python-docx2txt/'
  version "0.8-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56b1664112294b2bd8a064bb56e247d2c3abaa2835a94f335eb8af8b253882c2',
     armv7l: '56b1664112294b2bd8a064bb56e247d2c3abaa2835a94f335eb8af8b253882c2',
       i686: '13d24388e6dda771479a607f7930d1a665ed2681ab897d4fa97cedba36665757',
     x86_64: '2e17f92b1179243215b0fe4f1f1b3b89a3b3c202a9e6686785228aa64d6c26f6'
  })

  depends_on 'python3' => :build

  no_source_build
end
