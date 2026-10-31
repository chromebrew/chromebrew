require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.2.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cfb88dc373e6e1f7791653dd410507cf1c66ccdeb5ba3279b3dd8e4975d2df2a',
     armv7l: 'cfb88dc373e6e1f7791653dd410507cf1c66ccdeb5ba3279b3dd8e4975d2df2a',
       i686: '81fc8d6459583bb9ac4c4f1039565c6c2df80969723626bb6f8eab80f55c90e2',
     x86_64: '9f88d0bbc100ed5da7bd0874aea202e60727c97fc80f68fd30d0248f49242b09'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
