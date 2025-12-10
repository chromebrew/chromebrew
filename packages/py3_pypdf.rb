require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.4.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ef9e64d87669befebe9606e8ce7b58c5db46eddfb59d66f47bd28b7a582766e',
     armv7l: '2ef9e64d87669befebe9606e8ce7b58c5db46eddfb59d66f47bd28b7a582766e',
       i686: 'a76f1a98b68fbbc2162d0efdd882f96ddb264f7cb60d0cad840056a80e6cf048',
     x86_64: '2e3900c5e2dcd5fa1f204dc9c626f9f71dfda8e414540b3058a9d6960b3570a4'
  })

  depends_on 'python3'

  no_source_build
end
