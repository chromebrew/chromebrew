require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "2.9-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cd38e0d70fe32116c486d19158be6ccb553b22d5490edea4930ee7d2039c8e6b',
     armv7l: 'cd38e0d70fe32116c486d19158be6ccb553b22d5490edea4930ee7d2039c8e6b',
       i686: '2ea3f8fe53c0a15d779f48c87769cdff7c68061eddc0f682a8cad487a6d4e332',
     x86_64: '2af114615acebe5ef0db9942ed4abb1ae07b6de32f85ca8941c0f63c65dfdbc5'
  })

  depends_on 'python3' => :logical

  no_source_build
end
