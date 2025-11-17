require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.3.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eacbc9998bf370c425474d8ef11ea4fe2b9a67689b4a50887e03b1a595aeeafd',
     armv7l: 'eacbc9998bf370c425474d8ef11ea4fe2b9a67689b4a50887e03b1a595aeeafd',
       i686: '48bc770d2c7210c9ec4c673557a1c0c97a7e098222f909ed90b78a9ed673b355',
     x86_64: '7c8c2058b0309ef9eb183fca5215f87574f67e5c88c6387623c0c2239673c80b'
  })

  depends_on 'python3'

  no_source_build
end
