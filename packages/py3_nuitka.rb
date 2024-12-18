require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.5.7-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85a496ad48500a714cb41b49a0d9443c392b8c538b2e1ebe29623bb229843ae2',
     armv7l: '85a496ad48500a714cb41b49a0d9443c392b8c538b2e1ebe29623bb229843ae2',
       i686: 'df0097a48bc23c0ef6528ec65bd9e8900c7db6757785af3ef253c6ddd326d6aa',
     x86_64: '8b7ec30e33fdd8a1e0e6ea20753bdcb23dc57068c77e6f202d134ef5412146c3'
  })

  depends_on 'python3' => :build

  no_source_build
end
