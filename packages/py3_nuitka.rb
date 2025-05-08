require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.7.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4aae52be0fc82d27b1030c0ffaabe252f263252841dedb7ad548d688bd251c11',
     armv7l: '4aae52be0fc82d27b1030c0ffaabe252f263252841dedb7ad548d688bd251c11',
       i686: '5d194167e9bf53a706e4c46feceee2fae47f4688563dd2bbc9d9a71561141e88',
     x86_64: '2b21340ecbaa568d368ee6ff89bcc1eb29c1de0d87608b63bd3e89cfce1792a1'
  })

  depends_on 'python3' => :build

  no_source_build
end
