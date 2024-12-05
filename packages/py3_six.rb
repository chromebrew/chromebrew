require 'buildsystems/pip'

class Py3_six < Pip
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://six.readthedocs.io/'
  version "1.17.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c9cd488ed17b7751201619be71e005fa9999ab67adc40085fde8e54b629467e2',
     armv7l: 'c9cd488ed17b7751201619be71e005fa9999ab67adc40085fde8e54b629467e2',
       i686: 'fda792e13981c8a9b990259d59b812fd37ee186f9e56cb224c001e424bb7b169',
     x86_64: 'b9a05823ac20744f3b1e84f777eb4adfa47ff91cbc0e519ed1aad4c041e0d8b6'
  })

  depends_on 'python3' => :build

  no_source_build
end
