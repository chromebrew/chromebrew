require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.21.3-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a575b8ab56524f09e808773a669106ab2f4d6f523dca53b70c6f528467bb066',
     armv7l: '6a575b8ab56524f09e808773a669106ab2f4d6f523dca53b70c6f528467bb066',
       i686: '210b4cf4c09a5cd3c3b2ec71b19e022dec3000ba34e02b6d48ed5ebbd8a7f8d8',
     x86_64: '2ed52f7dcc81e5c1c1329e82fda2d17449a2a111edfcea2f417ae5a750db42e7'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
