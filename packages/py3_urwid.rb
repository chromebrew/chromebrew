require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.0.9-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '806829f880e168465f246ce4c0c6003dc44a90b7205faef0a4a0b517d79b34b2',
     armv7l: '806829f880e168465f246ce4c0c6003dc44a90b7205faef0a4a0b517d79b34b2',
       i686: '3eeffff52a05fd7da936e0475049c8a1a9c85e4f7c663fe3ed663603daed85bf',
     x86_64: '85b6d8bda8c99f47620dd2b2961615a073abd7d5b26c8edeb7d9f7e778c1e18b'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
