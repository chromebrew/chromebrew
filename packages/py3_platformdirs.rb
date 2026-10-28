require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.13.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2708bd0250242643a31f1366f38c241342e30988e8b0bfc48e5df0463af0dc27',
     armv7l: '2708bd0250242643a31f1366f38c241342e30988e8b0bfc48e5df0463af0dc27',
       i686: '43223fd67663ec1054da329a16be2106ff3af95e1888a36a30cf917bedbc3655',
     x86_64: '93614c923377ec8e10e3300881c56e11e22e49c719551a8c33c52345b071c463'
  })

  depends_on 'python3' => :logical

  no_source_build
end
