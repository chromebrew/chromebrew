require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "5.0.0-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a531e3b7dae529073d66f592c9e6e53e0f2d6ad85fab7c67eb6fa8171e164f6b',
     armv7l: 'a531e3b7dae529073d66f592c9e6e53e0f2d6ad85fab7c67eb6fa8171e164f6b',
       i686: 'f42dc01dadbf0602664557267a475b728f9786e752863410296ea6390263caa0',
     x86_64: 'c24a8e37f661a332ffdbd11b0b28b9b4de152d152e9f1542c07e2314daf25459'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
