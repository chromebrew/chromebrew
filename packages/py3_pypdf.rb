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
    aarch64: '9be4ce98687f16a6f559c5f6f28cb6c45068d5cf5cfb2c9b9ed2f23caaedaf69',
     armv7l: '9be4ce98687f16a6f559c5f6f28cb6c45068d5cf5cfb2c9b9ed2f23caaedaf69',
       i686: 'e17d457ef61fcecd77f24960e7205601468947aee66c66e930e912c9d746e22d',
     x86_64: '6196339ae8547f56797fd152fe6498f489c7ac576a4139beb5cb8475de39b9f2'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
