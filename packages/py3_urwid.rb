require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.2.4-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4d4a8188e07a7b1a86c2399c077c5017c456bb2224351cf05edf341c225764d4',
     armv7l: '4d4a8188e07a7b1a86c2399c077c5017c456bb2224351cf05edf341c225764d4',
       i686: 'd6d2274b5c2bf44f9919a64d71c36562ff9afc4acbc2fccf517e31ffc0228680',
     x86_64: '24c82bb6873627b1879174aeffd5df91a5f88dcb05d02ee8b28a21281ba829e5'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
