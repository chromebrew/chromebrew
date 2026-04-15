require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.10.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7effb9a2baa7bec310d57bcf501b62aff44faf6b9143edd00c02454b0ee82ccd',
     armv7l: '7effb9a2baa7bec310d57bcf501b62aff44faf6b9143edd00c02454b0ee82ccd',
       i686: 'c20f33a7cb6befa30fa87b3062ff17fb941b8012e518ecbb6227a149682453de',
     x86_64: 'ff879d7085b7ee0551eed26c26023bbb1c56315d3d8e11d75db2d972d8cc947a'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
