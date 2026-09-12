require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.1.3-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '074a9805759c83b1795398101ccb56e550d0d31f83754016397f981dda81a49b',
     armv7l: '074a9805759c83b1795398101ccb56e550d0d31f83754016397f981dda81a49b',
       i686: 'a1cbc76c0ee6213f0f68b71cf59d1a96fc4d88cd2dfabd2ccd445a8f1f64989c',
     x86_64: '35bb26c7cd6083f37c0cc3d70b503e9d1c19226db54a476e75c93d8f1e19d7bf'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
