require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.6.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '463621df95b5940cf6fdb398d2a5e334597e857cb6690e5e486008ec7b1f0dcc',
     armv7l: '463621df95b5940cf6fdb398d2a5e334597e857cb6690e5e486008ec7b1f0dcc',
       i686: 'cae019a83e65f1d18d8ec279f20ed0996e721c3f6358117329743aed9fbfb9ae',
     x86_64: 'f4bfc495bb0e2f8b40d3a9ee63864daa3352805a5888a1b542e951c148c8c591'
  })

  depends_on 'python3' => :build

  no_source_build
end
