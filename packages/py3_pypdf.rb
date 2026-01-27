require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "6.6.2-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '75086f72a63222fc8effc9042d367963994efc1c57ef20c8341ce6dcda570ed6',
     armv7l: '75086f72a63222fc8effc9042d367963994efc1c57ef20c8341ce6dcda570ed6',
       i686: '7fa674464cb9e0d1b511902c99647282c15be857bc1b22db3512a67f23385528',
     x86_64: 'bb571de0ee497b0095a1be99b2d66e23e27462c8a8f9d0fa6259c0f6ad6b1766'
  })

  depends_on 'python3'

  no_source_build
end
