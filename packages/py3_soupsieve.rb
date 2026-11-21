require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "4.1.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec0b70d0fbb0bdc85ed96852997c8abab265ad7206bd23241dc828ea1004fece',
     armv7l: 'ec0b70d0fbb0bdc85ed96852997c8abab265ad7206bd23241dc828ea1004fece',
       i686: '08190ce34479aaa6a7d0722c5c0edf6e0d6b181ba3819897d4aa5ff07326749f',
     x86_64: '739d208838fe7e7bcaa3242b3b919fe3df804318bcc5aff5ab14c1bf76e8895c'
  })

  depends_on 'python3' => :logical

  no_source_build
end
