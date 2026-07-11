require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "16.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6618cbc3355c26b7694a20ad7655bd6f1be33ba972dc8678e5804e6a715fb110',
     armv7l: '6618cbc3355c26b7694a20ad7655bd6f1be33ba972dc8678e5804e6a715fb110',
       i686: 'b4ecf9b03729d1fbe672ca3cce64e667b5e42d819f1ec2a166b39b5e4ec74b34',
     x86_64: '584549ea0672919895551306883dcbbf13c07e080b37f9eac5085c0d8a62922f'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
