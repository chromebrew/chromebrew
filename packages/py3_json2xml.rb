require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "5.1.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '245c31a5bcdd5acbfa28dad544823a3f9291d52785b9e10de1325a24602485af',
     armv7l: '245c31a5bcdd5acbfa28dad544823a3f9291d52785b9e10de1325a24602485af',
       i686: 'f47c84ccbf88a95a359cc6db0d9e5fcb468a748d9c553e3a36a838e92319450f',
     x86_64: 'a4714394c11e1cdff8752e66176776f5ad244f7639c6225c7bacdc2d51ba68e9'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :build

  no_source_build
end
