require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.7.12-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e2a3b2ff5afe76b1a933c6fb393dae8073bafeab9fc623e3c41c23713f54d3f1',
     armv7l: 'e2a3b2ff5afe76b1a933c6fb393dae8073bafeab9fc623e3c41c23713f54d3f1',
       i686: 'f444c56630acd9af5c3ce6ff7322a8afbea9ffdf9631f872750a662526ff1ee7',
     x86_64: 'a1f2063b423b7cbfde344ddf8fb78c5535b5fd96427015bfacdf6f946756efcb'
  })

  depends_on 'python3' => :build

  no_source_build
end
