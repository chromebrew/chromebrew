require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  version "26.4-#{CREW_PY_VER}"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6269647007742aa75830fb33e39e632b6a6140f5620d85338d0274808859f770',
     armv7l: '6269647007742aa75830fb33e39e632b6a6140f5620d85338d0274808859f770',
       i686: '877521f5d342be83c9c0c1923133acc4019b8ecfb8f1780a774b543b4c71de8f',
     x86_64: 'b95993b7c1dd4cc6875bc983fc84e85e69d0879016a93cf93f4e8eb39210d83a'
  })

  depends_on 'py3_pyparsing'
  depends_on 'python3' => :logical

  no_source_build
end
