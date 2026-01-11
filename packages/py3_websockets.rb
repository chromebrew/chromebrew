require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "16.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '841747b822c0bea93e90dedd11f700ce0aaf4101e187fcb26bbce2f6f547971b',
     armv7l: '841747b822c0bea93e90dedd11f700ce0aaf4101e187fcb26bbce2f6f547971b',
       i686: '30169f019db7c8360621de9340b660b438471b0117ab9215d5516eea227b1cc0',
     x86_64: 'aabda867e2b5cb93218a5f56524e15b8f4bab4e40497d45bda036122a81e0652'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # L

  no_source_build
end
