require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.0.13-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4217e04847b629b1dc29d91ffaa0e8a2dfe30d8a4270b92881378dc4fb45d95e',
     armv7l: '4217e04847b629b1dc29d91ffaa0e8a2dfe30d8a4270b92881378dc4fb45d95e',
       i686: 'd1845ff4ca3b15a8e3dbd947394695556bd866687a5211fa21d489993e962e26',
     x86_64: '540bfcd5f1ac24e449447985bc35c2c2fd3a163c18fc113aaf4eb4f6a5d9f909'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
