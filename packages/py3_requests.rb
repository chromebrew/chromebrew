require 'buildsystems/pip'

class Py3_requests < Pip
  description 'Requests is a simple, yet elegant, HTTP library.'
  homepage 'https://docs.python-requests.org/'
  version "2.34.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bc23c61f4809803d7a85a6259111ef7c3fe33144dd0114b56f0d5fbc489c6822',
     armv7l: 'bc23c61f4809803d7a85a6259111ef7c3fe33144dd0114b56f0d5fbc489c6822',
       i686: '5405490eb46e78fe999f8598b98deee9502aaccc2ffa0b2186d3af19da604c13',
     x86_64: 'f1798888c6a5e140d86ec093794ee3a9091b638d3cf19948bd926a54e3c684b9'
  })

  depends_on 'py3_charset_normalizer'
  depends_on 'py3_idna'
  depends_on 'py3_urllib3'
  depends_on 'python3' => :logical

  no_source_build
end
