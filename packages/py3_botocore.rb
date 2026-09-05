require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.89-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '822ee523d347fd4eee00bd13e801fd221e22638ebca8579dd6c74c7b08106230',
     armv7l: '822ee523d347fd4eee00bd13e801fd221e22638ebca8579dd6c74c7b08106230',
       i686: '8a9b735a457cd6ebf34b804f3f903c20b7bb4a819c37a17161afd5c9c39bb25d',
     x86_64: 'a040f4fdd1396666414f7daf47c1ddf1160806c0c6f834dedf9b83c0102197c3'
  })

  depends_on 'python3' => :logical

  no_source_build
end
