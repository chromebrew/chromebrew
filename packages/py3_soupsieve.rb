require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "3.0.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b3809587c67297d8379f6d3349c49134efed564d3118b0dd4aeed26dc588edf2',
     armv7l: 'b3809587c67297d8379f6d3349c49134efed564d3118b0dd4aeed26dc588edf2',
       i686: 'da9707f98b07e4ed3de29b63011ba7a2d2ccf5ff512c7fd40ca37c73e18a49f9',
     x86_64: '5a9d48904d9eef30c60e042a1ee4993bbefea7666d0000fe2e8a2b30b21e407e'
  })

  depends_on 'python3' => :logical

  no_source_build
end
