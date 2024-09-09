require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version '4.3.1-py3.12'
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd9bc7754d8ee35d811bc95180f6b97a8485745190683a3f69906d5d0e3ad8bd8',
     armv7l: 'd9bc7754d8ee35d811bc95180f6b97a8485745190683a3f69906d5d0e3ad8bd8',
       i686: 'ccdcaebad496311af8a7532dd862174d20d16ad518d99397ffdfc80b4a92e27f',
     x86_64: '12221950789af5cc71e18702a49c72d445e3ad6976b21cc03b84164bfad491e6'
  })

  depends_on 'python3'

  no_source_build
end
