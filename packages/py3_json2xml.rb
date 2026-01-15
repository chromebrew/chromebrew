require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "5.4.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b02b7fa1b3a2e440faac1b7407d98e2987f9dcd8e048d98f1ad8b902c5f6afca',
     armv7l: 'b02b7fa1b3a2e440faac1b7407d98e2987f9dcd8e048d98f1ad8b902c5f6afca',
       i686: '5879369db07cc0bbac19fce413c9dabc2b8a3ef75db4e9aa5403fdcfd45c27e5',
     x86_64: '3b5a95db18af2996f059f70806588cca01326efff2879c8174f326c166696705'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :build

  no_source_build
end
