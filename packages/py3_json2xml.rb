require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "6.0.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '879b134a770acd3fb03988851b57d5a1bb1b937c9d4886ea5254751ef916ba74',
     armv7l: '879b134a770acd3fb03988851b57d5a1bb1b937c9d4886ea5254751ef916ba74',
       i686: 'b149cf0b01c7127148883c4784b6bfd68b867e1068e9d4d54819ac3736dda629',
     x86_64: '98f93f824e903a3134fdac40af1822fa8a95c2d368a5681b9aeb6f2cf44cc5b7'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :build

  no_source_build
end
