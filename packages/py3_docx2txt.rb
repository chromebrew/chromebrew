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
    aarch64: '29386f609521d91d91fdfc273cf9a764f5cf3f1114518e6ee2a193e136f77b94',
     armv7l: '29386f609521d91d91fdfc273cf9a764f5cf3f1114518e6ee2a193e136f77b94',
       i686: 'c3d85ada0f4e1c8a1b85b6bf68cdd0f2e353c56955bae5e67dc4fda53cd8bce7',
     x86_64: 'd5512d0350db3e75bbc870698a434f0d4b1c81d176534623fcb93e28189a301d'
  })

  depends_on 'python3' => :build

  no_source_build
end
