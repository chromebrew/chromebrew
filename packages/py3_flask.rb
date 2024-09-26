require 'buildsystems/pip'

class Py3_flask < Pip
  description 'Flask is a simple framework for building complex web applications.'
  homepage 'https://palletsprojects.com/p/flask/'
  version "3.0.3-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a54594aa85ab33ba92fc9c077cd28f746475192221a43a6b86f6d3b34f354741',
     armv7l: 'a54594aa85ab33ba92fc9c077cd28f746475192221a43a6b86f6d3b34f354741',
       i686: 'e2104d7943cdb34d6e4b4a167b33a65fe241df96bd2c956c263261c6b3e5e921',
     x86_64: '7cbb67c1977ecc16f7d87365d44d3283e517cc986cbe1ea7f6eb1027fb9b9be3'
  })

  depends_on 'py3_werkzeug'
  depends_on 'py3_itsdangerous'
  depends_on 'py3_click'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  no_source_build
end
