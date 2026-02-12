require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "6.0.4-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8519be273b3ec301f2f7dde36e421cbb0ce8350e7afce8cec409386bde65ddd5',
     armv7l: '8519be273b3ec301f2f7dde36e421cbb0ce8350e7afce8cec409386bde65ddd5',
       i686: '9956e577d607d907a026d88cca4e75c01dbd08b10745371c344f938e48378676',
     x86_64: 'db0cbf5dc5ee8ea3db79f7e4521e1713932d860d500c16e9384dfb398406aa1b'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :build

  no_source_build
end
