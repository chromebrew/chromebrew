require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.4.2-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06795844d8718e3177c6d162def6e2bfd6163ee6cbbf9f6f6e65ccabea44ada9',
     armv7l: '06795844d8718e3177c6d162def6e2bfd6163ee6cbbf9f6f6e65ccabea44ada9',
       i686: 'd9f8464de655dd367478bf545c8c48d50014a56efa2e441de43b6f044531f436',
     x86_64: '168ae7c444477013a987511e183f2adb225ba2b3f3717eade1f5e3392cc0c8c6'
  })

  depends_on 'python3'

  no_source_build
end
