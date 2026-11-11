require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.44.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bc17962e7c99a9b73132387d66800664c531ab931b0c3aa65d078b96e590c6fb',
     armv7l: 'bc17962e7c99a9b73132387d66800664c531ab931b0c3aa65d078b96e590c6fb',
       i686: 'b037467ed4547ee1148f54e196042324ec812bcecb43c95c0e9aef0c1413c257',
     x86_64: 'e548b087b5933940b7a02082e4a4f5663f8535f95916b15c0bb908fa6c12849a'
  })

  depends_on 'python3' => :logical

  no_source_build
end
