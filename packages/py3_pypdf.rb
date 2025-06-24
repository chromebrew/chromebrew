require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "5.6.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7dbf6dbd0f2efa72cecefb46ea84b0054d35a92bc92b57b355fe6b36b7058fd6',
     armv7l: '7dbf6dbd0f2efa72cecefb46ea84b0054d35a92bc92b57b355fe6b36b7058fd6',
       i686: 'f857a980c6155abdb197e8bcd5e41b3d8484684c6366dd53e56296dcf5ee2149',
     x86_64: '2001f2b04f6cb9dfd6831bd9324b121b91fe3d6420d6dd5d1642af500ff1c025'
  })

  depends_on 'python3'

  no_source_build
end
