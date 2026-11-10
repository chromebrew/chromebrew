require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.127-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3bdec2de34dd36cc7a7d87dd0ad4becfb252751de0608f35bacd77e322fe547',
     armv7l: 'f3bdec2de34dd36cc7a7d87dd0ad4becfb252751de0608f35bacd77e322fe547',
       i686: 'bf1f2e7cc2d4720e942611df56cf09c9beaf0f512b10b45905d0deed450fa3bb',
     x86_64: '6b526af68399abd101d3e010379b9e0f6f9ab57fef3a0c25062e863a35ff10e1'
  })

  depends_on 'python3' => :logical

  no_source_build
end
