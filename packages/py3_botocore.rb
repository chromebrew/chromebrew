require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.11-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8876a9719e5825abed3d5d0e9d3077b29102f46f2562c37e9365246b5b941293',
     armv7l: '8876a9719e5825abed3d5d0e9d3077b29102f46f2562c37e9365246b5b941293',
       i686: '36c5a65036ceebfc06b1da8f294b90c9924efa70bf2a93dc85015e38b3b1c8c9',
     x86_64: '3af65e1f580e475486f80961df2b397831a1f82fb6774df5f29a069594ce81c6'
  })

  depends_on 'python3' => :logical

  no_source_build
end
