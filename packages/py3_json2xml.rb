require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "6.0.7-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd626956fa2763ab396b80c129ca5dd0a8c8e96ed4e1a48f9f6ef1c5ffafa2f95',
     armv7l: 'd626956fa2763ab396b80c129ca5dd0a8c8e96ed4e1a48f9f6ef1c5ffafa2f95',
       i686: 'a4fd3a4270a559248c24200ea54090e4d2261bf75be497797cf812659fc4273d',
     x86_64: '2fda446364fc359764bace6997c2c4fd6768e51e34d373f3ed08a7ee1e92d3b1'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :logical

  no_source_build
end
