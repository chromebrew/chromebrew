require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.1.7-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8a3b0bb94cd2880c6553d1a7e8ed1e557e93b65ff1528da1ab115799e8e095f8',
     armv7l: '8a3b0bb94cd2880c6553d1a7e8ed1e557e93b65ff1528da1ab115799e8e095f8',
       i686: '394d21d9b1ef4389deebfa3bc0d2e56ffe14b6cefce3a1153db99cc280f69134',
     x86_64: 'c3968495d40b4389322ef8c2fac38174c3544e93df0d3edff010b26880abbd19'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
