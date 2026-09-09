require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.90-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '689869705baf567ed28e7a9170e6c8130ab14bf401edf60f2e3d1167cc3f8866',
     armv7l: '689869705baf567ed28e7a9170e6c8130ab14bf401edf60f2e3d1167cc3f8866',
       i686: 'd52947723d2f064bef594cc0213f86c3d7ec19f7a0aa64bb11adc185574b568b',
     x86_64: 'aacbf90e33022155a10397f9c759cae2649083c8c1bca56661d8b984d1a929c4'
  })

  depends_on 'python3' => :logical

  no_source_build
end
