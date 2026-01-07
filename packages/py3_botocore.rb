require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.23-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bcae3f9fbcea115d4de0a05094434f9ca51d2e621c23a42f1dd5eee1cdf39638',
     armv7l: 'bcae3f9fbcea115d4de0a05094434f9ca51d2e621c23a42f1dd5eee1cdf39638',
       i686: 'b0fa0ebd13e1732b153112c4ef183e29166be8871abc29a4d3b603929c3a6b35',
     x86_64: 'b18dd2809a67cc15a508ab5d8576052d4078056bcb98e0b96a27bbec293eb547'
  })

  depends_on 'python3' => :build

  no_source_build
end
