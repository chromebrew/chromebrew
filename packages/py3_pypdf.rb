require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.11.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da34715e63b6a50781f9a683d437f765a399fb2245ba411cb0648fe3b6f2abbb',
     armv7l: 'da34715e63b6a50781f9a683d437f765a399fb2245ba411cb0648fe3b6f2abbb',
       i686: '8628af303d40c538bb1a3900fe6cd993f9674e272c5c8778a5a65c09d145da11',
     x86_64: '77fe65af5ea5c595532f11019d6e98228952c41e2b1779fb789625ce243d0da1'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
