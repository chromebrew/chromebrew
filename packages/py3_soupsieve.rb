require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "4.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c5de07c4c65f5df342a10bd77adea923bc5400d70c57479c9d017e9ff36208a4',
     armv7l: 'c5de07c4c65f5df342a10bd77adea923bc5400d70c57479c9d017e9ff36208a4',
       i686: '7433f3a70b9d0038aa30830a26d62782848b70349218ac002d6db2ec31e9852d',
     x86_64: '95e79d2a47a01688fe27309469c9162f7f7f50ebefc84315226620058cc284df'
  })

  depends_on 'python3' => :logical

  no_source_build
end
