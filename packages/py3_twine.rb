require 'buildsystems/pip'

class Py3_twine < Pip
  description 'A utility for interacting with PyPI'
  homepage 'https://pypi.python.org/pypi/twine'
  version "6.1.0-#{CREW_PY_VER}"
  license 'APACHE'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95b0a369e80bf461091524edee8aba4274d074ea955cc169c8dd7d014eb67cac',
     armv7l: '95b0a369e80bf461091524edee8aba4274d074ea955cc169c8dd7d014eb67cac',
       i686: 'c737f890901cf02cf67a2f43dcf78eb6b21e2fc2abbec344698ce51733bf3d38',
     x86_64: '1b5434099b6e68f77a27fa910b5d3ed0a21cb17d7a13cc288783a5fe271b9cb5'
  })

  depends_on 'py3_setuptools'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
