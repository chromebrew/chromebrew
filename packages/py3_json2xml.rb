require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "6.3.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a24f5eff475523d4886bf6ba44ca9955fa97ea3e4981fcc50ba07107d56d3209',
     armv7l: 'a24f5eff475523d4886bf6ba44ca9955fa97ea3e4981fcc50ba07107d56d3209',
       i686: 'a45dbd7103dd924c669aacb7ad325b12e2e1936ef35ef770a92e444587aac063',
     x86_64: '41b8633f9790c681c2f3ff0fc41806d78d316ef9b5799cc4dc00735f159c2920'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :logical

  no_source_build
end
