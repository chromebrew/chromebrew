require 'buildsystems/pip'

class Py3_xmltodict < Pip
  description 'XMLtoDict makes working with XML feel like you are working with JSON.'
  homepage 'https://github.com/martinblech/xmltodict/'
  version "0.14.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9375a14575b8028c2c7100bf8d3569b4b51b6e9072c6a6770162d421eed567a9',
     armv7l: '9375a14575b8028c2c7100bf8d3569b4b51b6e9072c6a6770162d421eed567a9',
       i686: '85c5fa3717a41c62b55a113971a459c6d2f8e7deabb32974725f08edc75175e4',
     x86_64: '734ad1f7e566e74c441aeb2d0e92b2608d1694a607ddfc2e85133aeebea4fd1f'
  })

  depends_on 'python3' => :build

  no_source_build
end
