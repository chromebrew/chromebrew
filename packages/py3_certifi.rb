require 'buildsystems/pip'

class Py3_certifi < Pip
  description 'Certifi provides Mozilla\'s CA Bundle.'
  homepage 'https://certifi.io/'
  version "2025.4.26-#{CREW_PY_VER}"
  license 'MPL-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ace6311be305ab3e12071c0b60c8c1462e90cce9a8f77d36db1e010375ddb566',
     armv7l: 'ace6311be305ab3e12071c0b60c8c1462e90cce9a8f77d36db1e010375ddb566',
       i686: 'ec57ab7170dc78f7ea185d85be3081241869a46bbe40568c1715d2ebc0aa8661',
     x86_64: '350f308b16b4f886128201c722b1fd1717f58bdfbfd3324bae44216bc1eb13cd'
  })

  depends_on 'python3' # L

  no_source_build
end
