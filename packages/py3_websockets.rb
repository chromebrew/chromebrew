require 'buildsystems/pip'

class Py3_websockets < Pip
  description ' Library for building WebSocket servers and clients in Python'
  homepage 'https://websockets.readthedocs.io/'
  @_ver = '11.0.3'
  version "#{@_ver}-py3.12"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_websockets/11.0.3-py3.11_armv7l/py3_websockets-11.0.3-py3.11-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_websockets/11.0.3-py3.11_armv7l/py3_websockets-11.0.3-py3.11-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_websockets/11.0.3-py3.11_i686/py3_websockets-11.0.3-py3.11-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_websockets/11.0.3-py3.11_x86_64/py3_websockets-11.0.3-py3.11-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e99b09d9084b0e4ed82014c51dd88e59253b748223ccf0e68b20279a750470fc',
     armv7l: 'e99b09d9084b0e4ed82014c51dd88e59253b748223ccf0e68b20279a750470fc',
       i686: 'a6d2a87d2bcaecb6d3a625e15b5b7f51f8102e2bbfebdbb27fc9e4294e0a9d8e',
     x86_64: 'ae8ee5d284f2b2d1fd43d153b3b4f423ed46a5eb94c93292f4922940dc30767c'
  })

  depends_on 'python3' # L
end
