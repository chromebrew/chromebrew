require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "8.0.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '509d9a0bc643249fb99b1392bf1a1d0177ca0c1d062678db73225c354b813302',
     armv7l: '509d9a0bc643249fb99b1392bf1a1d0177ca0c1d062678db73225c354b813302',
       i686: '16cde49a32355684d0c3ad05f38426219f220d84509426b0517eed74045efb88',
     x86_64: '6065a2153584fde966d879d3fb5cb7d2031d354f80bbac95167bc63181220ece'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :logical

  no_source_build
end
