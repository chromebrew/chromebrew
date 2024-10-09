require 'buildsystems/pip'

class Py3_werkzeug < Pip
  description 'Werkzeug is a comprehensive WSGI web application library.'
  homepage 'https://palletsprojects.com/p/werkzeug/'
  version "3.0.4-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b054ea23e135a21791e45e7d7f3811dcccb695d8f69dd4ec45abd14eec2b784',
     armv7l: '8b054ea23e135a21791e45e7d7f3811dcccb695d8f69dd4ec45abd14eec2b784',
       i686: 'edd38dd4c95bf3e5c377800d999f82b94126466d289fd414e3ef00d485af96bf',
     x86_64: '97db9a9e092c1cf1ab5fa9aeded984d3f27fac93ad931dcbdf3ef7ac318b610e'
  })

  depends_on 'python3' => :build

  no_source_build
end
