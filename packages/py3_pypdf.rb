require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.10.2-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a65c75cb53fd4165b35465644bd031b2527af0c9bbdfe93e567fa573e6e14827',
     armv7l: 'a65c75cb53fd4165b35465644bd031b2527af0c9bbdfe93e567fa573e6e14827',
       i686: '74d05ef31ad7c7124f029d508591703f1bf46e3a86fefbaf4048db1f8aa02162',
     x86_64: '0e4f28d2507712142d17e0b951eb023342ed4d7ae61c8c43942c6bc978dc9a0d'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
