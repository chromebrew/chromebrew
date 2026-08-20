require 'buildsystems/pip'

class Py3_idna < Pip
  description 'IDNA provides internationalized domain names for Python.'
  homepage 'https://github.com/kjd/idna/'
  version "3.19-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '855164ac4ad2c25a91d216974ca4d0651a45a6304f5a63a87763746334c76cb6',
     armv7l: '855164ac4ad2c25a91d216974ca4d0651a45a6304f5a63a87763746334c76cb6',
       i686: 'f059d613b97daf63525bcd1d3d1aca962f27adfe17f0604531db158cf079052b',
     x86_64: '6ecefb709b1d88e17ee38fd9620122941726913876f5841d2e67943d11712ed1'
  })

  depends_on 'python3' => :logical

  no_source_build
end
