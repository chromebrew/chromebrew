require 'buildsystems/pip'

class Py3_typing_extensions < Pip
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  version "4.13.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '691788a0feb370dcd9163e4bda9bafeea8667fbe3f461369322b79078dfe56fb',
     armv7l: '691788a0feb370dcd9163e4bda9bafeea8667fbe3f461369322b79078dfe56fb',
       i686: '903a8963bad5bde7820aa94c6c1d40e03dfe7f8ca02fd46cdc8fe532b43a5eda',
     x86_64: '75a4f5abfe3678c2da65e688d06676d2881e6d022f626f76d0f18f90c7eff02d'
  })

  depends_on 'python3' => :build

  no_source_build
end
