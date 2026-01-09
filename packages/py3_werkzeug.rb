require 'buildsystems/pip'

class Py3_werkzeug < Pip
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  version "3.1.5-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '842dbee6e1832b3e47cbaae70ca74ef5fdaefbd8be4d864f952fd195365f7739',
     armv7l: '842dbee6e1832b3e47cbaae70ca74ef5fdaefbd8be4d864f952fd195365f7739',
       i686: '87269dd4d03e913ce9ab117d32599e33496eee21c5596be403cd7580f49c63bf',
     x86_64: '64c2b7283c99ea7ba6d7bb7a2310ce16bcb31a8a489faf4f680653c6e4165cb7'
  })

  depends_on 'python3' => :build

  no_source_build
end
