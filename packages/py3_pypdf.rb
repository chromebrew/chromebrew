require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "7.2.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c8d1296772a29e303d5cf8afed05dc1650b7fc39c7ff712734d416c4929532dd',
     armv7l: 'c8d1296772a29e303d5cf8afed05dc1650b7fc39c7ff712734d416c4929532dd',
       i686: '95d3f7651763a52702e9493c291d94952f2e331ad108e27a97267c67fa2c5d8c',
     x86_64: 'c3db0d1a4c99b45f328163d0fa4cf9675d98c60cd2f74ad3e2d369873dfa4ca5'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
