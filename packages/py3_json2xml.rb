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
    aarch64: '0c308108b8769daceaf3f2c80807c58df55737ffbaa2e414153cf0d3fc04ef64',
     armv7l: '0c308108b8769daceaf3f2c80807c58df55737ffbaa2e414153cf0d3fc04ef64',
       i686: 'aafe7f5b305c5df02d28c6aed78fab0b1bca497fafc8f0d0ec2c46810ca5fa54',
     x86_64: '65f9fd88edd868c9b6d55ece9b092a92a555e06086b1482423c99aa90f4dd67f'
  })

  depends_on 'py3_dicttoxml'
  depends_on 'py3_requests'
  depends_on 'py3_xmltodict'
  depends_on 'python3' => :logical

  no_source_build
end
