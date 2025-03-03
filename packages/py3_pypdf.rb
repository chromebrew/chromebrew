require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "5.3.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '69a80ab1bcb0e586528b8f74ac520d46f4c0dc5b538c85b8cb6c04bf09ed2481',
     armv7l: '69a80ab1bcb0e586528b8f74ac520d46f4c0dc5b538c85b8cb6c04bf09ed2481',
       i686: '927c5b43c3ac675909fe95928f94e13d00fa3057f86c9084dd71bfd365be5d5a',
     x86_64: '3420c6dbfcbbc329f324ce63ab842e8eaf3ddbd9a106fe238784d66ee8952673'
  })

  depends_on 'python3'

  no_source_build
end
