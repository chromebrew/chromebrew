require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.54-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6495b5801c15770bc84e10197f87714455d0a31d8c515887b003c977f35cea9d',
     armv7l: '6495b5801c15770bc84e10197f87714455d0a31d8c515887b003c977f35cea9d',
       i686: 'f714dbea2e3a262e1778e5a3527136f18d9861d3556604034376f4eac1ebb468',
     x86_64: '41276263d1dcaac5f4f7ea9e9db8e59e56140cf29f58aba6b0da89e7c2d02d2d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
