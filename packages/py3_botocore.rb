require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.33-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52d42efe8a1e277419810e31ff369e0241f90b10bb036db532dedce97b595d88',
     armv7l: '52d42efe8a1e277419810e31ff369e0241f90b10bb036db532dedce97b595d88',
       i686: 'e6d2f850f3f957579fa3910223db0d0ec86e34d84043af43733240c9a7b63a63',
     x86_64: 'b8cff999fe45e9ae6f4a46ec25e909875448bb07df44d8d6c49a6c16c6f78c50'
  })

  depends_on 'python3' => :build

  no_source_build
end
