require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  version "26.3-#{CREW_PY_VER}"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51d755bfc7a00345e22a65f2e2eed922e24a703c551403d415665a37e3ec9b72',
     armv7l: '51d755bfc7a00345e22a65f2e2eed922e24a703c551403d415665a37e3ec9b72',
       i686: '0e1bbf02f3afc686668b40a3f2551f2a0b58b0451967c72b22022dc0c2170da3',
     x86_64: '9bb911a6693f7a4b6c6c77b0589efed48367d8016b4583be8c7672e199d87e24'
  })

  depends_on 'py3_pyparsing'
  depends_on 'python3' => :logical

  no_source_build
end
