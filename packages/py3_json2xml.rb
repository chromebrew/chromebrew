require 'buildsystems/pip'

class Py3_json2xml < Pip
  description 'json to xml converter'
  homepage 'https://json2xml.readthedocs.io/'
  version "5.2.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7f1ee4b0d2c2913bc1fb07bc32b3ec53d2705379819b85fb6804dbebf79b8014',
     armv7l: '7f1ee4b0d2c2913bc1fb07bc32b3ec53d2705379819b85fb6804dbebf79b8014',
       i686: '920519ae31e71c3263ab5c4113ca8addf19b96aeefff9815de0d340eda0e1deb',
     x86_64: '9ce66dbc22432fe4431ed9b8a9e4ec447c1d431a1c8a4382d162b288795068aa'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :build

  no_source_build
end
