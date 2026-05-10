require 'buildsystems/pip'

class Py3_xlrd < Pip
  description 'XLRD is a library to extract data from Microsoft Excel (tm) spreadsheet files.'
  homepage 'https://xlrd.readthedocs.io/'
  version "2.0.2-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '910c0ee5748c11fdade3526d0db807ecbc4ecbb6b3865d15724afd9153c82bdf',
     armv7l: '910c0ee5748c11fdade3526d0db807ecbc4ecbb6b3865d15724afd9153c82bdf',
       i686: '5bd0842d8c109c2a4d7c793feb16fd8c4e4ccc206f97be584f5058600925ee78',
     x86_64: 'ce700db403e7fc9ae8d6a8e917cb743113f5fde2e6b227bcc94ecd2043032d44'
  })

  depends_on 'python3' => :logical

  no_source_build
end
