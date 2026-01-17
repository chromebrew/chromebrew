require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "6.0.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bfaaedf0049de0be6f3897bcd942117d2755cb1ca628e2c4e8cbcc15a429fc6e',
     armv7l: 'bfaaedf0049de0be6f3897bcd942117d2755cb1ca628e2c4e8cbcc15a429fc6e',
       i686: 'f0a1c943d168fa0daab3423481b07782dca7710822b786df3bdba94498d4c5f4',
     x86_64: '8d9a2a02ddacbdda7cc46e19761175a138cc8a19e62a473fecebe733ddd39e5b'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :build

  no_source_build
end
