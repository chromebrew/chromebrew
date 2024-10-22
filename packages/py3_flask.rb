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
    aarch64: '20ad7742a3e8d8018fcdc00fa6ff9e51fa704e5044a997153ad08ae18e80581f',
     armv7l: '20ad7742a3e8d8018fcdc00fa6ff9e51fa704e5044a997153ad08ae18e80581f',
       i686: 'de34673a3c1bae87f5a859e1bba3ac4e63d74a000ee9d3058bc57227d91ba4e6',
     x86_64: '1a839e592e58d24d2360e4dbb8aea1eaca1c0deea6873ab3004c5d4ec5494836'
  })

  depends_on 'py3_werkzeug'
  depends_on 'py3_itsdangerous'
  depends_on 'py3_click'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  no_source_build
end
