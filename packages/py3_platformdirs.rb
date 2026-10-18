require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.13.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d736def77abc3061dfab77d20cb7f222afac1d606a5e2f2232f4c11434564e3',
     armv7l: '7d736def77abc3061dfab77d20cb7f222afac1d606a5e2f2232f4c11434564e3',
       i686: '868175f7913f43401d788c1667910aa14b61ff9d02d8db7b4d9e63665d80681f',
     x86_64: '5d5d0c2cf8e808b8355c3ba71fff8b9a440546fb21e3487db00c66c063ce6c37'
  })

  depends_on 'python3' => :logical

  no_source_build
end
