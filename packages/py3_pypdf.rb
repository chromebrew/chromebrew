require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.12.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e032967143b3e4cdcbaaf80669a915b1e27b47003f039b830ffcf28cf90186e3',
     armv7l: 'e032967143b3e4cdcbaaf80669a915b1e27b47003f039b830ffcf28cf90186e3',
       i686: 'db634e68c2e09e0f5cd5bfff60b3011e38ad184fb3ef8b941d9f39866a99d763',
     x86_64: '4d73cb830b2c1af36b08791eed2f83fa41ac95010c81642af2e8df5942f22223'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
