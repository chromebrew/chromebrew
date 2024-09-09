require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version '13.0.1-py3.12'
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'python3' # L

  no_source_build
end
