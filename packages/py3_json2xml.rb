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
    aarch64: '90a4695bdc6cd97d0a897860b464e991de2ea44aa33de67bf523f29c7ff38682',
     armv7l: '90a4695bdc6cd97d0a897860b464e991de2ea44aa33de67bf523f29c7ff38682',
       i686: 'f04b0d4a0b4c77d40e26f276d3670047d3436aed45c23f75d78a15cff5852a53',
     x86_64: '1db1643ebff5e5c1291dffcf6eefce0dd98427346b8528cbe83ae03cbcbf754e'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :build

  no_source_build
end
