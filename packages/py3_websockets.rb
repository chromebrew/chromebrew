require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  version "17.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3ba49b9457fb93acfdfb0845e6e19e0e35d6c7547cd1add76761b1772305649',
     armv7l: 'f3ba49b9457fb93acfdfb0845e6e19e0e35d6c7547cd1add76761b1772305649',
       i686: 'cc7929677b42a92338df9f7047de602bb7e0fb82fb3ace274a13ce7563c53368',
     x86_64: '5dcb03cef2468ab866d22176162f950e17d5150fdfd684fbd3fa7c0f6d6fa981'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'python3' => :logical

  no_source_build
end
