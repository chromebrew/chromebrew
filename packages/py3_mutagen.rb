require 'buildsystems/pip'

class Py3_mutagen < Pip
  description 'Python module for handling audio metadata'
  homepage 'https://mutagen.readthedocs.io/'
  version "1.48.1-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3eb760cf990529d68bdb618d262713acb3996c205ed2267a940fae90e829c549',
     armv7l: '3eb760cf990529d68bdb618d262713acb3996c205ed2267a940fae90e829c549',
       i686: '9ce2a1e370494db90a7c06748675fc5d1d04ac18b50796797901a6b50e9cbc75',
     x86_64: 'b878ea1b518f237e221b5d69f53d7a2ff7debd369a9af1e07229ddd628be7139'
  })

  depends_on 'python3' => :logical

  no_source_build
end
