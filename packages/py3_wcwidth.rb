require 'buildsystems/pip'

class Py3_wcwidth < Pip
  description 'WCWidth measures the displayed width of unicode strings in a terminal.'
  homepage 'https://github.com/jquast/wcwidth/'
  version "0.3.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '92c68a594dc7ab313103988c0c78affe1c6319f46ac25d187d3b696507b76756',
     armv7l: '92c68a594dc7ab313103988c0c78affe1c6319f46ac25d187d3b696507b76756',
       i686: 'f91eca06a2fb475fbb3aa98df37a3b16e092e1eb2c85777f10dc671a3bf78123',
     x86_64: 'c6e1c71b11ec7b31153e0da50cab7aa7cc00488ac579c2afb48e6b2a7c2b228d'
  })

  depends_on 'python3' => :build

  no_source_build
end
