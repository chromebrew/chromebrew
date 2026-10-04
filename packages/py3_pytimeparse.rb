require 'buildsystems/pip'

class Py3_pytimeparse < Pip
  description 'Pytimeparse is a small Python module to parse various kinds of time expressions. '
  homepage 'https://github.com/wroberts/pytimeparse/'
  version "1.1.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '163b1618562bd5ff3a748ec15d166a8ecc92023acfa71fade28b2a876163bb67',
     armv7l: '163b1618562bd5ff3a748ec15d166a8ecc92023acfa71fade28b2a876163bb67',
       i686: '98be0c762d62a280aed361b000d6a1df02a800fb8a150b53ef21e22c96fa4e29',
     x86_64: '82c60d95041bcf2a773e2f221209bbc7e764571eed3dae62ff40aa167670095e'
  })

  depends_on 'python3' => :logical

  no_source_build
end
