require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.16-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c507b879fec19e215727cddfe733f5295c64a9851e68ccade63209cf25fe0e22',
     armv7l: 'c507b879fec19e215727cddfe733f5295c64a9851e68ccade63209cf25fe0e22',
       i686: 'c7155333e52af7a9cfbf392548985d7ebce261e839aa59fc15aa9ac4f2d49389',
     x86_64: 'b5a8114480edcbc250674c37f52442d73cdd362042b72ac95044ddd6c6ce72a8'
  })

  depends_on 'python3' => :logical

  no_source_build
end
