require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.50-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa2fceb503807acb50d5f799bf02a8702654a9b2d3e654d5479b6b26cb180d2f',
     armv7l: 'fa2fceb503807acb50d5f799bf02a8702654a9b2d3e654d5479b6b26cb180d2f',
       i686: '616dc3fa2ea08ce83ff6b1c10499a880058c3c162ba5e94ea6df562a44a8e95e',
     x86_64: '08443087f05419ec94019d3eb89901750f79dea290044e6ec4f62b388b3e2fd3'
  })

  depends_on 'python3' => :build

  no_source_build
end
