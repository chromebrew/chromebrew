require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "5.2.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '77a6599dc51b440653139bf549943e9fcc44d5fed68f545edcb2946299f9a32c',
     armv7l: '77a6599dc51b440653139bf549943e9fcc44d5fed68f545edcb2946299f9a32c',
       i686: '54c06cbf142e585feb97a35066533c52aa1f76aa3a552d23a82fd9090fd49660',
     x86_64: '4b26e2de1d0ccc7c73ef76bece609563323b04622cda9208c1a8c2a13699d78e'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :build

  no_source_build
end
