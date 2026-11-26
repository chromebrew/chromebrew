require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "5.2.1-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7dc5e1373303b3248a89fbda0ce9513152e30277ac4f8d84b3f4900c902aa42c',
     armv7l: '7dc5e1373303b3248a89fbda0ce9513152e30277ac4f8d84b3f4900c902aa42c',
       i686: 'ec03b7570eaae8bc28f54763932844f5bf95b1319f2350ef9798f4be18c2e9d3',
     x86_64: '945c453bd03ae3f6f5a2055d005ce4218547ee38d77a06d7f504b594a961d0bd'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
