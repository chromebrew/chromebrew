require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "14.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5437388a3cb80991700e71320f89401c6c2cd01f78a0dc7f6d6420c6c4f348c3',
     armv7l: '5437388a3cb80991700e71320f89401c6c2cd01f78a0dc7f6d6420c6c4f348c3',
       i686: '9a7858106d3accc2d3cd750652e4bc10abf37192fced64a8f1487b8863f75ecf',
     x86_64: '0206bc8e048897a3d0c403a3dddaf8229000c1c27447dcebb573e6d60b02b497'
  })

  depends_on 'python3' # L
  depends_on 'glibc' # R

  no_source_build
end
