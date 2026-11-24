require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.3.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e5c806d06d4a23f4239598049821fd407dbc208ed2570c0fea0bc45b44a5d2d5',
     armv7l: 'e5c806d06d4a23f4239598049821fd407dbc208ed2570c0fea0bc45b44a5d2d5',
       i686: '637f36029a9ef992ba99a59ac6d5eac27473565e5731e0b64d51568611ba24da',
     x86_64: 'edd43e2fdcf128b45bf2111a215089113bc57ba1ee3561fe96e32d60e45ce70a'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
