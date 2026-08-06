require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.65-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2419cf9e0a9ecc999ca061b402099b1560a5673312b76f3e08c7b9585d2ce7ad',
     armv7l: '2419cf9e0a9ecc999ca061b402099b1560a5673312b76f3e08c7b9585d2ce7ad',
       i686: '8e3d232432ebe4a0ec5565eb7eccbfdf967d03d1a9312aa6ea38bf13df32cba7',
     x86_64: 'ce06efa2e648082565260f98ca583e369b9c6ba6dd54b19e073783276fc1a8a1'
  })

  depends_on 'python3' => :logical

  no_source_build
end
