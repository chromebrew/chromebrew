require 'buildsystems/pip'

class Py3_urwid < Pip
  description 'Urwid is a full-featured console user interface library.'
  homepage 'http://urwid.org/'
  version "4.0.4-#{CREW_PY_VER}"
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aac4282970bf2c97e9cbfd75f1c9cf8550fd852a491da2cf8883bea1d99b1ecb',
     armv7l: 'aac4282970bf2c97e9cbfd75f1c9cf8550fd852a491da2cf8883bea1d99b1ecb',
       i686: '2d63fcd857e05ae5a4686b43ba25cb842f0276f9c64429c1bbf0e294efb60df9',
     x86_64: '96583454d234820aee22446e94349847913291be767319932a78427abc75bb42'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :logical

  no_source_build
end
