require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.7.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6db66b5f01fbfdc1f7130b3a9da17173a9d13c7a200497d2d241b444f9a41927',
     armv7l: '6db66b5f01fbfdc1f7130b3a9da17173a9d13c7a200497d2d241b444f9a41927',
       i686: 'f895674bf4a13bf67f02c65edc7aadbeec7526baa96864202108ceb923d13d51',
     x86_64: '2b21340ecbaa568d368ee6ff89bcc1eb29c1de0d87608b63bd3e89cfce1792a1'
  })

  depends_on 'python3' => :build

  no_source_build
end
