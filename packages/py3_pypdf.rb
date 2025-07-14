require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "5.8.0-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '61a29440d213e5ecd1f46923d9f73878a788b9837667cc282e4ee0140618ece0',
     armv7l: '61a29440d213e5ecd1f46923d9f73878a788b9837667cc282e4ee0140618ece0',
       i686: '3627477a248c94599b04172055c322a10c3c51f9084ae1ed49458fdf1bcb1f41',
     x86_64: '9052982d823882a31fe52ada5f44a8e5bbb8112877b378c4d86fd0aac5fc5a5f'
  })

  depends_on 'python3'

  no_source_build
end
