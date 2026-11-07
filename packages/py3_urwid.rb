require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "5.1.0-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '712a2add82321b337df9f401266a8cad364c788c9a27ad748ff7c1df35afd30b',
     armv7l: '712a2add82321b337df9f401266a8cad364c788c9a27ad748ff7c1df35afd30b',
       i686: '6850174afbfca993829f5617dbc95eaa0c90da999a67d770eab8abc6af908972',
     x86_64: 'b8c1ba3efb639db0058c6f5330561f2ed1b808a48228fd8592273a058ebf7f2a'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
