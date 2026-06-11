require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.13.2-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d1d11c6ae6b2a1d0e54787081cabca3cd55b3c9dd36bb86fbd7438a376389ff',
     armv7l: '7d1d11c6ae6b2a1d0e54787081cabca3cd55b3c9dd36bb86fbd7438a376389ff',
       i686: 'b0a3987884bedb18d6297411553a0c0a742e0299fd64bda99237d039f70540e7',
     x86_64: 'b09145b7bc603a7e2d631f320575e2009455c2ca68415350d4b37ac12dd7f5fd'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
