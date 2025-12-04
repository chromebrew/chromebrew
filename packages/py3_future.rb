require 'buildsystems/pip'

class Py3_future < Pip
  description 'Future provides clean single-source support for Python 3 and 2.'
  homepage 'https://python-future.org/'
  version "1.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e43861bd9a514fb4842bd2b956348313c3cf8dfb9d992ea4af00a92ee8264afd',
     armv7l: 'e43861bd9a514fb4842bd2b956348313c3cf8dfb9d992ea4af00a92ee8264afd',
       i686: '9c42d8cc71d79b1145a46876d6650fd261b73e59522c168dfc218b1042b7d615',
     x86_64: 'e58ad09b7f052885689283551e8f4b58f462a1f8b9e2b383483109f64202c1a1'
  })

  depends_on 'python3' => :build

  no_source_build
end
