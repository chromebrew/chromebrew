require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "7.0.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ed8b8d0f3c8988fc06f99c4ffb01fde96084eea64b3400c3da09b4734a5f1c85',
     armv7l: 'ed8b8d0f3c8988fc06f99c4ffb01fde96084eea64b3400c3da09b4734a5f1c85',
       i686: '19c21817894e4035f340e0e9a9944e2cf1e44a48de4bd2d01e633e7e802a2ce0',
     x86_64: '6e38466d1dd8a13fecff94b48cf8858958eba1f04f03d26246c4e55e9067a99e'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :logical

  no_source_build
end
