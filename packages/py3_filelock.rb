require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '449bd7c79ea7ce027aec4f812de6f30aeccf5212c5e6d708b95c836fd10512ed',
     armv7l: '449bd7c79ea7ce027aec4f812de6f30aeccf5212c5e6d708b95c836fd10512ed',
       i686: '7af6aadaefbdf45772714beb0300eb4c1126aa76d252b27709ab5dbb47c633b6',
     x86_64: '9e2a5989d2d2d7baf3abab1b3da09e478569db0f39965cdcb628ee7a7c922e90'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
