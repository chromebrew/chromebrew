require 'buildsystems/pip'

class Py3_flask < Pip
  description 'Flask is a simple framework for building complex web applications.'
  homepage 'https://palletsprojects.com/p/flask/'
  version "3.1.3-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c993af720ea777fad1b4b1ead6245e528175e5b6b589f8b1eb11766bacefc3b6',
     armv7l: 'c993af720ea777fad1b4b1ead6245e528175e5b6b589f8b1eb11766bacefc3b6',
       i686: 'fb89968321e3a0f3a53a46bf05ea5802bf5a195d56c86e7c782f7aa73846dd60',
     x86_64: '7d24ded440ef3fa0974e2217bcaed1459fee71e1883c00d7535623334be07cf9'
  })

  depends_on 'py3_click'
  depends_on 'py3_itsdangerous'
  depends_on 'py3_jinja2'
  depends_on 'py3_werkzeug'
  depends_on 'python3' => :logical

  no_source_build
end
