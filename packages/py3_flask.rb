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
    aarch64: '6b4e3aaddc02bb24599a57e4258e65920d16d28c86ddddda8881fe5d11274261',
     armv7l: '6b4e3aaddc02bb24599a57e4258e65920d16d28c86ddddda8881fe5d11274261',
       i686: 'e5753eb57a4a6f5080cb64fd00af86472bed54866727aa26c77ba42b429dce6a',
     x86_64: 'ed25efed773de132122c44950a993cc832e9416903a2332d5543a20b882a5342'
  })

  depends_on 'py3_werkzeug'
  depends_on 'py3_itsdangerous'
  depends_on 'py3_click'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  no_source_build
end
