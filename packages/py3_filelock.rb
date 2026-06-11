require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.29.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a4e9b2e368b5cd52217d1c80e0bea0ec7dec70cea214a0b52c50726028fae275',
     armv7l: 'a4e9b2e368b5cd52217d1c80e0bea0ec7dec70cea214a0b52c50726028fae275',
       i686: '401fcbf5d390c294ea07498629c6131784cfde08b1e09b6c03f057e4437fb915',
     x86_64: '6e3964e9bbacd5f57330495593d7095ba955cba745093845243031e5874c8c60'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
