require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "6.1.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2f2e95667bb8c080df67da6dafaf139df58d05ece4809656c2ee40fcf60d6e72',
     armv7l: '2f2e95667bb8c080df67da6dafaf139df58d05ece4809656c2ee40fcf60d6e72',
       i686: 'd7743d60a01f3047d66c1e48c1515bde05c38e1284fc664e470937d4ffb9909a',
     x86_64: '706ea94a3219152ea0bd28e186d745a377b5cedff4558bf02a7b2b81ee0f2af6'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :logical

  no_source_build
end
