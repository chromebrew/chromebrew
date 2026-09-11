require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.92-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b60c7619f4f998ac15cf3d2a470f268ce79502ca0c814b095da870debb8cefb2',
     armv7l: 'b60c7619f4f998ac15cf3d2a470f268ce79502ca0c814b095da870debb8cefb2',
       i686: '41ceafde2fe030dfbf296c5987081d7553d7a40ead4d2bb349281f71d1a69b1c',
     x86_64: '421ff447f5fea2c1b1a4b9feae5a2d4f3b8c4c71139fbe711b62b2065f405d23'
  })

  depends_on 'python3' => :logical

  no_source_build
end
