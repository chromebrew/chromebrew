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
       i686: '9b48dde70c0a3f4ad2f78bf6fc0e13a0091a921d616231d4e5a1b76920481d84',
     x86_64: 'cff13eb2de6bcaec8341485e814043587010073b9fff5cc0bfb28eecf38c4071'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :build

  no_source_build
end
