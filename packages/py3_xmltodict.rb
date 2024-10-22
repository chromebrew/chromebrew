require 'buildsystems/pip'

class Py3_xmltodict < Pip
  description 'XMLtoDict makes working with XML feel like you are working with JSON.'
  homepage 'https://github.com/martinblech/xmltodict/'
  version "0.14.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a7feb951e5b978a92e67220c7a1c3ffaaab578bc9dab0c68c7c0a721aae646f4',
     armv7l: 'a7feb951e5b978a92e67220c7a1c3ffaaab578bc9dab0c68c7c0a721aae646f4',
       i686: 'a707a431edba0a60f6d601df75789cfdfae3ab0d39ee40d32eb263b2c27ceaeb',
     x86_64: '57697be5cc7b27b4a70cf91be79802ec88d79d15103b1b379ccedd23dae84c41'
  })

  depends_on 'python3' => :build

  no_source_build
end
