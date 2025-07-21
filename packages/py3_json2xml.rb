require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "5.2.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '664609c1412f80d0858dcd5fa08fdc2bd5c813b56a2c4236c3535330917bed48',
     armv7l: '664609c1412f80d0858dcd5fa08fdc2bd5c813b56a2c4236c3535330917bed48',
       i686: 'f47c84ccbf88a95a359cc6db0d9e5fcb468a748d9c553e3a36a838e92319450f',
     x86_64: 'a4714394c11e1cdff8752e66176776f5ad244f7639c6225c7bacdc2d51ba68e9'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :build

  no_source_build
end
