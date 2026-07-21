require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.52-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '930d52a38d3885c4f86da439ba3ac40df55eb5f870f92a51ebf50b10b675d3d9',
     armv7l: '930d52a38d3885c4f86da439ba3ac40df55eb5f870f92a51ebf50b10b675d3d9',
       i686: '82d9eebb79ba24dced5fb506d1536b105120ad324185eda2ea94a40d98139088',
     x86_64: 'f8599de7fa8d6f36806a985bec9817e5e2c72604e0748d8b45440475b591ef61'
  })

  depends_on 'python3' => :logical

  no_source_build
end
