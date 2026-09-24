require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "7.1.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd55178d2bf2fb8d6e4fdb9f565fa59a2adf8309b8817d53c4b0a54db7ed66286',
     armv7l: 'd55178d2bf2fb8d6e4fdb9f565fa59a2adf8309b8817d53c4b0a54db7ed66286',
       i686: '7a690ceac2a3fb477d82fb672529e8ad95316e8baddcd3c48e6a69a9a197fc7b',
     x86_64: '620fbc19f137db2ae2243ec0a7c0fd42b3f0fad4d16ce4e0a987ad67bd699fb8'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :logical

  no_source_build
end
