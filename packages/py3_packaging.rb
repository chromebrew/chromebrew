require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  version "24.1-#{CREW_PY_VER}"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cf54fa1369ce1c11d17ed3b6ed0e367d14a28fc8962740602a7b5a2a911ab546',
     armv7l: 'cf54fa1369ce1c11d17ed3b6ed0e367d14a28fc8962740602a7b5a2a911ab546',
       i686: '8ff3369655d16b4862059a2b77dd3d8924d4321899f51686c5255e8ab3b495e3',
     x86_64: 'c23fe088338fefd878b9f7631d121f0e17e6be5b49097467f856bf0aed34a70d'
  })

  depends_on 'py3_pyparsing'
  depends_on 'python3'

  no_source_build
end
