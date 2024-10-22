require 'buildsystems/pip'

class Py3_mutagen < Pip
  description 'Python module for handling audio metadata'
  homepage 'https://mutagen.readthedocs.io/'
  version "1.47.0-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e5f14ca0975cd3f8472def8f4b34d4104fb1b0e3e320c4b7ab814d1079299c6',
     armv7l: '8e5f14ca0975cd3f8472def8f4b34d4104fb1b0e3e320c4b7ab814d1079299c6',
       i686: '458bb53169d6f7a8943fae2f402319ab0b32c0b8e5baf37e30d0535c6e9316c2',
     x86_64: '4a100d266c0c97a8fccd592a3185913c15bb762ac1fd2590ad248349b4fa244f'
  })

  depends_on 'python3' # L

  no_source_build
end
