require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "6.5.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f12115c13d5c741c669421fd1a703d6c54b75a8bcf44e163a3156cc49554f72',
     armv7l: '4f12115c13d5c741c669421fd1a703d6c54b75a8bcf44e163a3156cc49554f72',
       i686: 'b6804ec84b05e298cd9a7591466a1a88d6b8eb35d2de9fa5dd8a9bed54b9af31',
     x86_64: '48f7f932c5b53f35ee5a9fe69f035a90f19f1dacabda00bfc91feb0b2f79b8bd'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :logical

  no_source_build
end
