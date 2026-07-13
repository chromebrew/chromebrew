require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.8.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3483135bacaebaf308d744c37daeb0d0deb82ed369cbeea4558ede2e4fe09eab',
     armv7l: '3483135bacaebaf308d744c37daeb0d0deb82ed369cbeea4558ede2e4fe09eab',
       i686: 'ed3ef3ea80b2eca5f7bef6882808baf330dc0071179f8a2c826d4dc8d38670b7',
     x86_64: '49c7773cdefc7bad6cc555f3ec906bd136436d3bddf08f1f202e34708787b56c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
