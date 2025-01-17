require 'buildsystems/pip'

class Py3_tomli_w < Pip
  description "Tomli-w is a lil' TOML writer."
  homepage 'https://github.com/hukkin/tomli-w/'
  version "1.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '89ba40fcc4f8d82ded2ab7b57e662aec78ef8de8e321a51f2b2d08716a57eed7',
     armv7l: '89ba40fcc4f8d82ded2ab7b57e662aec78ef8de8e321a51f2b2d08716a57eed7',
       i686: 'e786c204b56b3026558798a518a4a84d69d95a675d99dbb80beeb8c7f60abf83',
     x86_64: '53d1aa38a1c73cdb2fc9f3277024e954a0ab3fb8da53454901c0e0b4978f0262'
  })

  no_source_build
end
