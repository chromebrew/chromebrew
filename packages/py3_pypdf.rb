require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version '5.0.0-py3.12'
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '961940a98ff3d662b0f68644d00c91c860cd40a1057264e77b8626fc37165ba5',
     armv7l: '961940a98ff3d662b0f68644d00c91c860cd40a1057264e77b8626fc37165ba5',
       i686: '8a9abcde0e1486952e4f2f08b5bfed3880d4f44449adc926b23408997250fb0b',
     x86_64: '66d7f2ba1617606a7e183137a83229cf5f51022955304423b3ffaa0cb8f69de9'
  })

  depends_on 'python3'

  no_source_build
end
