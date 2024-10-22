require 'buildsystems/pip'

class Py3_dbfread < Pip
  description 'DBFread reads DBF Files with Python.'
  homepage 'https://dbfread.readthedocs.io/'
  version "2.0.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '043a945a351a61933d4a6f69eaa79532d670775f2958636bd5cfa53e4db3d43e',
     armv7l: '043a945a351a61933d4a6f69eaa79532d670775f2958636bd5cfa53e4db3d43e',
       i686: '4d5628a154daa4151252803ac2295d8b17b31dfa08579070b8f2f30bc04ebdac',
     x86_64: 'b192e930a38f5ae8768e965ca8baa29ff853ae7c19e41b2315d5e721b4532013'
  })

  depends_on 'python3' => :build

  no_source_build
end
