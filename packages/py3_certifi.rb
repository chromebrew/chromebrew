require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2026.10.18-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6256046b6567c3fc81d24c5effc9a9265e3ab6308754a8bc5ba58b759e4368c9',
     armv7l: '6256046b6567c3fc81d24c5effc9a9265e3ab6308754a8bc5ba58b759e4368c9',
       i686: '938de8a042bf7e65625bc8b3fde886622d047b6adda106f6a2b3406d711b5418',
     x86_64: 'd7cb78ff41532e35ef53bb5aab0b2a003dfe08ca43bd147fe2de36a26fe485dc'
  })

  depends_on 'python3' => :logical

  no_source_build
end
