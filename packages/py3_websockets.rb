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
    aarch64: 'b01ba7bfb66d52913dfd457da635198a78f73be3a3176e3f366263410bedab6b',
     armv7l: 'b01ba7bfb66d52913dfd457da635198a78f73be3a3176e3f366263410bedab6b',
       i686: '6ec062099b31d8a1c40b4807d3f55f024c8d67ae08aee08333c4bdef7b601810',
     x86_64: 'cd885b242be28fe15ed4e2742dfea49f5600d74e9e871ac7656272dc86fc9875'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
