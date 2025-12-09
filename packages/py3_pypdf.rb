require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.4.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f0ea1ec4c800107b16148c11371aceb37a5285fd04f0ea0987f0dc7c341a8a8e',
     armv7l: 'f0ea1ec4c800107b16148c11371aceb37a5285fd04f0ea0987f0dc7c341a8a8e',
       i686: '565eea8a37c5bbb87ddbf7cfd367d7ff6d4b9ef92347070692d11ab2c68e978f',
     x86_64: 'ddd5a2b4798e52c5b68d4ea0e2bf354b75d903870567a0a042d9af1b3c74bb96'
  })

  depends_on 'python3'

  no_source_build
end
