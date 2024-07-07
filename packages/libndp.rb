require 'buildsystems/autotools'

class Libndp < Autotools
  description 'Library for Neighbor Discovery Protocol'
  homepage 'http://libndp.org/'
  version '1.9'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/jpirko/libndp.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7c8a67bdf4aa0591cb96221037b3489ea897935faabeca90a5d44518d069bdba',
     armv7l: '7c8a67bdf4aa0591cb96221037b3489ea897935faabeca90a5d44518d069bdba',
       i686: 'bf609c1911545b304ed8b9196cca833c0af8806d9af180b80f3a4cb8bb3af231',
     x86_64: '51374e8a22adfc253787a0f883c26809c174517961e7699b9e56c28d4fd41209'
  })
end
