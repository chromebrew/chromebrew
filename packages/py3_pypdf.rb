require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.17.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3a1e9068a86615312362aa4d36552bd10b76a11f8f2863f492e0ca973babbba3',
     armv7l: '3a1e9068a86615312362aa4d36552bd10b76a11f8f2863f492e0ca973babbba3',
       i686: '8d78c18914e5b4d14aae336d68cce759336da74c07414e06f0832d6a1b604eee',
     x86_64: '3c9ad040e20ffe84aa9400673623879d15dc4661cd5f18139449a859450d2771'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
