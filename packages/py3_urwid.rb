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
    aarch64: 'cdac5b48227cc677102fababe9596031323cbb2eb67ccc5cbe33da97fc39f880',
     armv7l: 'cdac5b48227cc677102fababe9596031323cbb2eb67ccc5cbe33da97fc39f880',
       i686: '77da714357ec5925443a96fc2c96fdb109b00d47c6b6689309f5c244f5a2e5a2',
     x86_64: '109fe0168be7282873e3231c7436396fe7e07c09fcb847a837d9f3464cf234fa'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
