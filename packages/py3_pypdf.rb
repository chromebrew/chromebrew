require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.3.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f20127d5371a437bb4a38b3972091bb080a0bd18e75b5ba0b5a805ed13ee8704',
     armv7l: 'f20127d5371a437bb4a38b3972091bb080a0bd18e75b5ba0b5a805ed13ee8704',
       i686: '6374b9efa5810c47ebaa42147fca8525db459494d5284b000d34b5db2b344cc3',
     x86_64: 'c5c4207273adbb10ae5405d77bc327e584c1d2a5a6f0c5d4e6121f227fd73a8d'
  })

  depends_on 'python3'

  no_source_build
end
