require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version "3.14-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8805180221b2fb2bd9306814fb53c658bb80947bd3b10da45d2ab333151d5d8a',
     armv7l: '8805180221b2fb2bd9306814fb53c658bb80947bd3b10da45d2ab333151d5d8a',
       i686: 'efa82546636b0ee002383fd5f7ea8c809c47ff59ddb743856629918f3fafca1b',
     x86_64: '82ee82e83c48209c7a0f7f4b9f0cdb5c524b1b6618ecb483c097d4170ea48c8a'
  })

  depends_on 'python3' => :logical

  no_source_build
end
