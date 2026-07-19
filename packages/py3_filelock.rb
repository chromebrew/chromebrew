require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.31.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '20e33de080ad54789ad4e35830ec823fe930257a3d5879691694ce3d938b3d52',
     armv7l: '20e33de080ad54789ad4e35830ec823fe930257a3d5879691694ce3d938b3d52',
       i686: '',
     x86_64: '65fa041115087aa31f14741df7296cb9a50ac54823524c6c741a0fbb161d11f5'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
