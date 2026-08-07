require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.15.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c918d904f68cc9059188a1f9418a81c2b1f4afd7560baa3a2785671ce74a86de',
     armv7l: 'c918d904f68cc9059188a1f9418a81c2b1f4afd7560baa3a2785671ce74a86de',
       i686: '6f84a610beec55bd15ab05df4efb59f18ec49c5678ad16192c6d86d723d3d9c5',
     x86_64: '8c9bd9b643aba45a933e33a08eccea57743589410adb04d667ce53aa6710f3c4'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
