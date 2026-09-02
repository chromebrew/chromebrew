require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.11.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '601beca18cd66999ded73832f28f67a98ddce363251208268fb514c108159cd0',
     armv7l: '601beca18cd66999ded73832f28f67a98ddce363251208268fb514c108159cd0',
       i686: '5a3fe44c463b5de48efa32d431e5ab4da544f9362f6fc7f1802b9bb709848ff1',
     x86_64: '3c2e42badb5ae3366bd5171a804c878f29230347fc269b8e5007d37ba8cfd49c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
