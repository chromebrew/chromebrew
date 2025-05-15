require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "5.5.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '72b43737d13937e618d228d3a811623289a7ec7504bc17d311cba3a2a2279ef8',
     armv7l: '72b43737d13937e618d228d3a811623289a7ec7504bc17d311cba3a2a2279ef8',
       i686: '6adb66df1afbe3c33b849acc51ad12d5734fe058b706054693a693d128c235bc',
     x86_64: 'ba56b0de33a1368a3c910d04af5e724cb09a79076ea675412bf2fa2b58615802'
  })

  depends_on 'python3'

  no_source_build
end
