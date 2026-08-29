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
    aarch64: 'e26fbb839b7678942eba81bea3063ebe77cf0b07b4708474533e07b280bf34d9',
     armv7l: 'e26fbb839b7678942eba81bea3063ebe77cf0b07b4708474533e07b280bf34d9',
       i686: '291a2723a8231372692504c0219ce7c08ff792c26163b41bfd6808dd02e0d9cc',
     x86_64: '291a2723a8231372692504c0219ce7c08ff792c26163b41bfd6808dd02e0d9cc'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :logical

  no_source_build
end
