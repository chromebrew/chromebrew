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
       i686: 'c30fb59f1e8c5e70177ae98503cec92191cd3e4f4ae087f82ea69fb8f7690213',
     x86_64: 'b4be6edc886909be84b1d97ff13333136708e435c06be281a24dfd5d7852065d'
  })

  depends_on 'python3'

  no_source_build
end
