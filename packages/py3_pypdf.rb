require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.14.2-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8abcfc9f4d6691a1a549ba6fc25f6a9d545322da0583dbad20882e08e6e2ea55',
     armv7l: '8abcfc9f4d6691a1a549ba6fc25f6a9d545322da0583dbad20882e08e6e2ea55',
       i686: 'bcb0041a64cfc2fde4c1de0933e8d31bd25fd2ea723ab3ce1cc66537422fd55d',
     x86_64: '50b1f2c3a1ebe8d8db76a0840553ec3067125851389f738658ab1161e8311070'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
