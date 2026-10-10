require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.19.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bc5e66b6670737d598e3c87ed93ad0967c00acff0f50d9d89190e949ea8f6a20',
     armv7l: 'bc5e66b6670737d598e3c87ed93ad0967c00acff0f50d9d89190e949ea8f6a20',
       i686: 'e17d457ef61fcecd77f24960e7205601468947aee66c66e930e912c9d746e22d',
     x86_64: '3dd62fdd79e88f5c2ce1f5a02d97e85c0c65f425db29f4056784bc8297e8b01d'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
