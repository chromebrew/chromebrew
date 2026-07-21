require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "16.1.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9b4ddd10ff9c4451d2e0f38032c2cb6b003994fd482cc64c54d1348297c4e01b',
     armv7l: '9b4ddd10ff9c4451d2e0f38032c2cb6b003994fd482cc64c54d1348297c4e01b',
       i686: '771c1a162bf5a1a362f60f0719a54841fcd1eba7c157c45e6fca78328d0cea6e',
     x86_64: '56c0ec250acfc6dc643a2ff4e456614ca9b9a48a07f632361c2f244ffba6d79b'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'python3' => :logical

  no_source_build
end
