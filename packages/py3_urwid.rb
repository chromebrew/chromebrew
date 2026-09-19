require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.1.5-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9aaccb6615274ac1b87982eb00422d9921b5117b1749d33bea95c3a8f7d2b362',
     armv7l: '9aaccb6615274ac1b87982eb00422d9921b5117b1749d33bea95c3a8f7d2b362',
       i686: '4a7a8cb8f619242865877627eb462a768460dc22e88522f83f353ce1a118daa5',
     x86_64: 'b5278a9cc18e37a9a5bf49b0b6a44f8de6313122b5ce962e8110a07248bf53dd'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
