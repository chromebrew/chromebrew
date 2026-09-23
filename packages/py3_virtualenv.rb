require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.10.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c088082050d756dcfef4449c561733d39c71771810fa2e4804cf30dbef612408',
     armv7l: 'c088082050d756dcfef4449c561733d39c71771810fa2e4804cf30dbef612408',
       i686: 'aaf6e6ce561791bdf866eb526443d0b24e3aa15bf9e67e387a893e4adbb16b92',
     x86_64: 'e344d5cff5de377c053937cc1f811fc942063d5b86b09a90fafaa6ff39358224'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
