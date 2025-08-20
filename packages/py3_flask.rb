require 'buildsystems/pip'

class Py3_flask < Pip
  description 'Flask is a simple framework for building complex web applications.'
  homepage 'https://palletsprojects.com/p/flask/'
  version "3.1.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6bc785e5ebe3589ba6aea5a00ca67bc1a10f5ac065056ff4978cae802677a92c',
     armv7l: '6bc785e5ebe3589ba6aea5a00ca67bc1a10f5ac065056ff4978cae802677a92c',
       i686: '7f5f9caf3cb1f9b9a7438924e63a1ef42f024d2509580ad5bb369f39ce708ff2',
     x86_64: 'd7298701b4ea26a52186b61831b6b6d3304825f05583f17d6475d1288eb11646'
  })

  depends_on 'py3_werkzeug'
  depends_on 'py3_itsdangerous'
  depends_on 'py3_click'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  no_source_build
end
