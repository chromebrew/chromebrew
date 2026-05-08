require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '69c80162a72bba2c2b59554c8115dc9394f0f949565d887675d52fb67b19471d',
     armv7l: '69c80162a72bba2c2b59554c8115dc9394f0f949565d887675d52fb67b19471d',
       i686: 'e109dd2ddc956a8e0668735d51660b827c1f3fc5da0fa4a1fbcccbf10f0f73ae',
     x86_64: 'ebe6567092ce6e0a085d431df3425ec0da10919e8dd4263d2d2c9ede73b58026'
  })

  depends_on 'python3' => :logical

  no_source_build
end
