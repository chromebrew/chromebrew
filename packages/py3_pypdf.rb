require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.21.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '490cee383cc201d1d171bc1584a1dd2312d6829ad3cd940a5b88cf855ae65905',
     armv7l: '490cee383cc201d1d171bc1584a1dd2312d6829ad3cd940a5b88cf855ae65905',
       i686: '06bd4112c6a4d9ff27d85e868629bd71c70cb8241f6d763a7dc4bbbf92c750d7',
     x86_64: '2f8722a9425a6a58e46f09e4c7b389683f0b34f3b6e392f484c9de575be0fb8a'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
