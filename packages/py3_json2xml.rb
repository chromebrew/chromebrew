require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "6.4.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '44e3811630d858186e5cc660858ff884e049d57171e2f4d796523338c28b2b9c',
     armv7l: '44e3811630d858186e5cc660858ff884e049d57171e2f4d796523338c28b2b9c',
       i686: 'd33b77ad039caab6c990686d046cd69b8639fbcdbbf568d3f445040acf596529',
     x86_64: '9751eaf80529a245a8f3d2a108637b4c703102a6a24e9f1a6184d8d2806c9137'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :logical

  no_source_build
end
