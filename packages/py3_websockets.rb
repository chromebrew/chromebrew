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
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_websockets/11.0.3-py3.12_armv7l/py3_websockets-11.0.3-py3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_websockets/11.0.3-py3.12_armv7l/py3_websockets-11.0.3-py3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_websockets/11.0.3-py3.12_i686/py3_websockets-11.0.3-py3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/py3_websockets/11.0.3-py3.12_x86_64/py3_websockets-11.0.3-py3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ee9f174e40937fd731bb66f496554cd740571f6de6b19f29e285e0f397c586f0',
     armv7l: 'ee9f174e40937fd731bb66f496554cd740571f6de6b19f29e285e0f397c586f0',
       i686: 'e639477f5f0044f5764dceee7aac74d1902128046b47957930348d01761815cd',
     x86_64: 'e7f49a05a22346ee8230dd26a26a77c25bf9fd15a71bf1b03ea231e81006432d'
  })

  depends_on 'python3' # L
end
