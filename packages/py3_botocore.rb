require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.44.4-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2469e05af3f14bdf10753a20cc0be6fde42172a1c32244e1f427536ae2d188dd',
     armv7l: '2469e05af3f14bdf10753a20cc0be6fde42172a1c32244e1f427536ae2d188dd',
       i686: '99af3eac8ea9c0b1529356ad0e401debcae6ac6268c1d374965163b0fa64d3be',
     x86_64: 'dca18d3c839a3453573480f864afc1e2c493d620370c23c30df5a0b53e7ccf16'
  })

  depends_on 'python3' => :logical

  no_source_build
end
