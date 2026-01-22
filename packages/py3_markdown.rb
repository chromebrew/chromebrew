require 'buildsystems/pip'

class Py3_markdown < Pip
  description 'Markdown is a Python implementation of Markdown.'
  homepage 'https://python-markdown.github.io/'
  version "3.10.1-#{CREW_PY_VER}"
  license 'BSD'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '81f649859c096e26b2a14f1724c05782123ba7058228b026e111f4ebd5338c31',
     armv7l: '81f649859c096e26b2a14f1724c05782123ba7058228b026e111f4ebd5338c31',
       i686: '83bf5624168e4f773cbbf43b87da2b66932f71f859368620cf2d572159be7833',
     x86_64: '876f0fc3f756ad09e88c3b01244e58b9722f2ba4e7ab70f5a3f8076e16a15e15'
  })

  depends_on 'python3'

  no_source_build
end
