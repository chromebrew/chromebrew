require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.1.3-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '24fef872ced2a5cb0f86a37739fac016b6ee72b83ee81b4fd908859ae3340fdf',
     armv7l: '24fef872ced2a5cb0f86a37739fac016b6ee72b83ee81b4fd908859ae3340fdf',
       i686: '28163911487bd50209698aac69c8281ecdf5b0db2a1baac2037cf2a4a24a593c',
     x86_64: 'd1095499abd3532199d45a56064c95db344a5bce2b0ee6c1b3a02f87247324ac'
  })

  depends_on 'python3'

  no_source_build
end
