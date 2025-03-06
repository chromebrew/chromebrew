require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "15.0.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf84173ec4df8a028dbd69f8b1228c47b1502b4e75f4dee4ae14a8e38563bc44',
     armv7l: 'cf84173ec4df8a028dbd69f8b1228c47b1502b4e75f4dee4ae14a8e38563bc44',
       i686: '6d246425b61aa1a8c9622bdb7ebee49b7153bd36235d85e9d6f0fbbb6b57d60a',
     x86_64: 'd2543abbd466e94bf1b8300bfd6fdbdbccd71fd63da519a5b204be276d39d66e'
  })

  depends_on 'python3' # L
  depends_on 'glibc' # R

  no_source_build
end
