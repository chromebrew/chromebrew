require 'buildsystems/pip'

class Py3_pluggy < Pip
  description 'Pluggy provides plugin and hook calling mechanisms for Python.'
  homepage 'https://pluggy.readthedocs.io/'
  version "1.6.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8f3973cb9c5e0315980e1cc9391f98808ab4e6faae5ff7da8c05f92244d7d432',
     armv7l: '8f3973cb9c5e0315980e1cc9391f98808ab4e6faae5ff7da8c05f92244d7d432',
       i686: 'bc796288260a80dd132689f1d7afef221016197e7e1a7b64e42ac78060d30d39',
     x86_64: '6084a5525e4bdbfc9c13fe432d2c729a1a686cc1bcfd42c1cb1f5c0a40299267'
  })

  depends_on 'python3' => :build

  no_source_build
end
