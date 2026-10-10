require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.20.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e7b3707b617c24a9e35e455c4e3511f3165ba44b582b1872abaa2fc74afc0380',
     armv7l: 'e7b3707b617c24a9e35e455c4e3511f3165ba44b582b1872abaa2fc74afc0380',
       i686: '4df846c9a9af377ee835f4118b9e99504c6b539dc3df65a98437a5af6b798328',
     x86_64: '61a9cd57d3a9aad5a21700018a38a5caf9bff0713393104f663c73b6755a742f'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
