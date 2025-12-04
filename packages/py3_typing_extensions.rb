require 'buildsystems/pip'

class Py3_typing_extensions < Pip
  description 'Backported and Experimental Type Hints for Python 3.5+'
  homepage 'https://github.com/python/typing/tree/master/typing_extensions'
  version "4.15.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd6c5d68827fd4ebdde2c2573784820e6840a6db06b31729a0f4211159a9d2ae0',
     armv7l: 'd6c5d68827fd4ebdde2c2573784820e6840a6db06b31729a0f4211159a9d2ae0',
       i686: 'd655deeefe677c16b7f82b06f16899945d498f0a417ab7967d30eca862a5c377',
     x86_64: '014fca72fe3c174dad3ccd46ab44cdb19f16ca375beae52578ebe557b1a54879'
  })

  depends_on 'python3' => :build

  no_source_build
end
