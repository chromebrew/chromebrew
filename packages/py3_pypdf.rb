require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.1.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0d9965a2761d683df05c814c40cd607524e5801d4564607d09edd346f1595d93',
     armv7l: '0d9965a2761d683df05c814c40cd607524e5801d4564607d09edd346f1595d93',
       i686: '13c2da368b97d7c506ff4b8aa87c1ca2673b3cec4d3c8aec30f6364ced076eff',
     x86_64: '8c05679776aaedf49120b94c02c9cc185bcfc33c54384767c01809b943f68979'
  })

  depends_on 'python3'

  no_source_build
end
