require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.0.2-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ef839cf58f444b4cf4fce91db3328d394e1ab9ae39345c4b04b75fb63e1d2cf7',
     armv7l: 'ef839cf58f444b4cf4fce91db3328d394e1ab9ae39345c4b04b75fb63e1d2cf7',
       i686: 'a635f4ee5005db449ce5728c843d77f96398f9d921e330f418f99fd28bf7b538',
     x86_64: 'cdfe0f40e7ab85215cb3718c367748ef91072675c13436164c38cb00e346f933'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
