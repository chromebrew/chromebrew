require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "17.4-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f62598489f4bd55cb9223db697865f67b07975e0a4b78e82199b1ca652a7e52',
     armv7l: '5f62598489f4bd55cb9223db697865f67b07975e0a4b78e82199b1ca652a7e52',
       i686: 'b2948bbe9d19ec3391b587c76c6d33be77f979ba03b56d11e6f38d10f6e6ac4d',
     x86_64: '15b424fdc53f95f3adcf9299708728243701902c780e16b7f386086f96f75c98'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
