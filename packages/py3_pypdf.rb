require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "7.2.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a05b0a45ac88877e5399820b108fd3b275c2b15aca11d4f77aa2f5a2c09a1d4c',
     armv7l: 'a05b0a45ac88877e5399820b108fd3b275c2b15aca11d4f77aa2f5a2c09a1d4c',
       i686: 'e82871f554e5debecca48e8f4fb2c40c7cbbac97881729413b670fa3967f5e66',
     x86_64: '45d32d99d950abd3577ac7238940bd5a09fbfb07eb95ed4664b971f421da3660'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
