require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  version "26.2-#{CREW_PY_VER}"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3f08311dc768ace192b25840a3818143a9b08f63d95e15f3d9f6d8694994a98d',
     armv7l: '3f08311dc768ace192b25840a3818143a9b08f63d95e15f3d9f6d8694994a98d',
       i686: '4f6254c014a222dfe4ab8f7a1dd798ba3fafeae2f23c4b552f770c9c1e1de85d',
     x86_64: '9c95524413edbf6a77af74273f55f98d4d88a06f810175b6a04e62dba130f953'
  })

  depends_on 'py3_pyparsing'
  depends_on 'python3' => :logical

  no_source_build
end
