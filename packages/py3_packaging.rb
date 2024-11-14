require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  version "24.2-#{CREW_PY_VER}"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '184bcd669d842315c0d1a0bca6eecf01d93e4ecf182d4cb2fe617ac017a29d42',
     armv7l: '184bcd669d842315c0d1a0bca6eecf01d93e4ecf182d4cb2fe617ac017a29d42',
       i686: '08dc146d9eed0436204ae2aa8d7e7ff92193f1a00050def999ae510797eb8674',
     x86_64: '521e245880b11a3f58052b2c1425ddde86cb85ab0d9ba990664aba8019f78601'
  })

  depends_on 'py3_pyparsing'
  depends_on 'python3'

  no_source_build
end
