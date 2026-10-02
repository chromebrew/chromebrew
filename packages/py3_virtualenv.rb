require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.14.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4da77648fae2b4a54a57d7feb76a825db55086ebc660729d0905cf77d9ff2c01',
     armv7l: '4da77648fae2b4a54a57d7feb76a825db55086ebc660729d0905cf77d9ff2c01',
       i686: '748691cdc4f23aafc6b8aa140bc585d3d2939bbe6704c66c3817359e92643542',
     x86_64: 'b2774f9f5e0af4dbb6ef428ca3dcc3943a3e1f86b12135f468e3ec3d04c1370f'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
