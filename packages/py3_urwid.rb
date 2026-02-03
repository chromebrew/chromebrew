require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "3.0.5-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '21cc93c19ff438637266bc092f754207ca85e680a4cb16040aa50235e63dc65e',
     armv7l: '21cc93c19ff438637266bc092f754207ca85e680a4cb16040aa50235e63dc65e',
       i686: '2cbf7875f05d389dbfdfc6671350469f66efdc448196d9bc6637a9d650fc679c',
     x86_64: '20fed0830d382c7251b9bdbb3d4714d89e502afb29c891760b9ea48679a122a9'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
