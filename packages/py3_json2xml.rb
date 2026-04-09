require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "6.0.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd6a9aee23be3cc8e12faeb6a6b3631c235e61828807e2d274e64258b552cecb8',
     armv7l: 'd6a9aee23be3cc8e12faeb6a6b3631c235e61828807e2d274e64258b552cecb8',
       i686: '47f33cc7f58e11316755b22f3289c752e0b9aa99104053ce9f613212c0db18a9',
     x86_64: '32a2438b7d07b3d85f308d9bd05b064f34a8e83955f9efdd193b6d4faf7a3862'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :logical

  no_source_build
end
