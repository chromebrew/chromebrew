require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.10.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'befc070040580cf172407eb8f2728df8c3a0fb4cc678e7cf05850722a51cee5a',
     armv7l: 'befc070040580cf172407eb8f2728df8c3a0fb4cc678e7cf05850722a51cee5a',
       i686: '096fdc35948e7361cb6fe61daa215e07f21373361eda81e3c1416602e77edf02',
     x86_64: 'a9d5be41011f33e77196a06321e4e9427c0efc7c00e5e7f28b1c56fce35c7794'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
