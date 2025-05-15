require 'buildsystems/pip'

class Py3_flask < Pip
  description 'Flask is a simple framework for building complex web applications.'
  homepage 'https://palletsprojects.com/p/flask/'
  version "3.1.1-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6b4e3aaddc02bb24599a57e4258e65920d16d28c86ddddda8881fe5d11274261',
     armv7l: '6b4e3aaddc02bb24599a57e4258e65920d16d28c86ddddda8881fe5d11274261',
       i686: '9b4929fcaf08e7562b2cdde8de35e5914be21231cb1b4c65b837da996f752fda',
     x86_64: '52b73404a5a3de0e2ae765029d7e4dcb467409b0efc1ebe962e52738209315b4'
  })

  depends_on 'py3_werkzeug'
  depends_on 'py3_itsdangerous'
  depends_on 'py3_click'
  depends_on 'py3_jinja2'
  depends_on 'python3' => :build

  no_source_build
end
