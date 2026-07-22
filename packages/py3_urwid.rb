require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.0.5-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc86da45e07bf15c214de5d8439f2e2e028ef29244cf245ec52122e7d4207650',
     armv7l: 'fc86da45e07bf15c214de5d8439f2e2e028ef29244cf245ec52122e7d4207650',
       i686: 'afc3f80e7f9d8a4de1d8fe9ed2ce4087a2991a2d151b6cc7b108364928fca5eb',
     x86_64: '932aed158e3d84855d63c82198e74dc0506c0cfd6374f0129ae9db16a314139f'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
