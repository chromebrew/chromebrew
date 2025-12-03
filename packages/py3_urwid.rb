require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "3.0.4-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c7e32810e09b5158bc338997c781e3ac04de6446970b60b0041edbe4423390dd',
     armv7l: 'c7e32810e09b5158bc338997c781e3ac04de6446970b60b0041edbe4423390dd',
       i686: 'bad67cbd08238fff3ab4efc71c9f665b78775ea8ec7287e46523a90973bc5d5d',
     x86_64: '197d95c396deb0d874db4944fe309901d6beed90eb13eaaf16483f6e083c876e'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
