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
    aarch64: '6f3a3fe961f8798db11ec6a7066591de9e4ad6bf1b64c6c4496379ea4dd4eea8',
     armv7l: '6f3a3fe961f8798db11ec6a7066591de9e4ad6bf1b64c6c4496379ea4dd4eea8',
       i686: '9c42d8cc71d79b1145a46876d6650fd261b73e59522c168dfc218b1042b7d615',
     x86_64: 'e58ad09b7f052885689283551e8f4b58f462a1f8b9e2b383483109f64202c1a1'
  })

  depends_on 'python3' => :build

  no_source_build
end
