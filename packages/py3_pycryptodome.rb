require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.24.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d0fce67f01e62633d8c54ede49b28cca114cc5c41c8e0a103f36b3554bbd7b3',
     armv7l: '2d0fce67f01e62633d8c54ede49b28cca114cc5c41c8e0a103f36b3554bbd7b3',
       i686: '21cf91521277f2050a1e75a0dc914ca60ab99c855d9bb386611630421e3af155',
     x86_64: '0b4f32ee2428c64304b47b0368e070c9b016cd84f559e57ee051ca833b623062'
  })

  depends_on 'glibc' => :library
  depends_on 'python3' => :logical

  no_source_build
end
