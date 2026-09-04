require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.1.1-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b3ed835fb900a85f9658bf4a07309e9fe81c0ecf74552d5518ae036e59bc2f23',
     armv7l: 'b3ed835fb900a85f9658bf4a07309e9fe81c0ecf74552d5518ae036e59bc2f23',
       i686: 'f00cc9330b2b2d690325d0352d356ec4ee853690ac58f55cddc9b33d59a9d22b',
     x86_64: 'e27aac48ddb84e1b678852815791ed2d53920515bcedfedbdf8d1b0909d45725'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
