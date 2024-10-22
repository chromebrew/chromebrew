require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "5.0.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cd33b321c0c1252f3eb43b0ea88a0b31e9754a852e0404692f8966c7c7046296',
     armv7l: 'cd33b321c0c1252f3eb43b0ea88a0b31e9754a852e0404692f8966c7c7046296',
       i686: '46bfd5f2161546db8f37830f4c5728605dcbbd921ba962bf0e202b9d9a064668',
     x86_64: '1002767dbfbea6a707d4cbb324e70ef9cb1e97565b710b3d88a1e574d9752c7d'
  })

  depends_on 'python3'

  no_source_build
end
