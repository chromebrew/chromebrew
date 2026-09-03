require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.1.0-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9ad532595ba8f63423357159ff4e74874a46359d0beae748cf4c427b3814a77b',
     armv7l: '9ad532595ba8f63423357159ff4e74874a46359d0beae748cf4c427b3814a77b',
       i686: '46477436dff04ce60790b16b6fceb2c39786679e5188818a0cef1bc930e3654b',
     x86_64: 'ad9440223e7af87c6e974cf1db871c9f6c7403c43a14f5f288eafa110772d96b'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
