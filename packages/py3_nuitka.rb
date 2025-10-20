require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.8.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '95d898acbfccdb746b23e06b8b06d8f424f8d975d73909b5f86d9f39f9a14cb4',
     armv7l: '95d898acbfccdb746b23e06b8b06d8f424f8d975d73909b5f86d9f39f9a14cb4',
       i686: '496e15b040fd4b8bcfc9499b3983724c7cbb1db9aff4ef270d07755fdad7e616',
     x86_64: 'f8405c977ff9f2ce9a2519ed9a665d9a62c2700cfd1d4256424cdc0c66d3aa88'
  })

  depends_on 'python3' => :build

  no_source_build
end
