require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "7.1.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd375486a48b974ea4464c8f1ef1cc71b15a6ce41e84d82c62d9fe8fa25558286',
     armv7l: 'd375486a48b974ea4464c8f1ef1cc71b15a6ce41e84d82c62d9fe8fa25558286',
       i686: 'e2d4ea7970a51c8ef79d5c26dc3f69f56e28a5222d5971894bd443b1695fbd14',
     x86_64: '76122a4e47e4a73b2a0084183a9f295a82fb5b44c7a1b7ba008e7f90db64ae2a'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :logical

  no_source_build
end
