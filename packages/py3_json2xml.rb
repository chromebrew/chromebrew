require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "5.0.5-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e0edcc7592817d9a3861a72188c03ff2df2a1640ad68dae035d967537190becf',
     armv7l: 'e0edcc7592817d9a3861a72188c03ff2df2a1640ad68dae035d967537190becf',
       i686: 'a6c6f746638b5a1a79cac0a44e2538fec6ddc0338f1b5c7e2c6568703e19fd48',
     x86_64: '8ec323f4e15cb788d594877458096e526a01b149a28f0f163a6da7f2ac6b1ae3'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :build

  no_source_build
end
