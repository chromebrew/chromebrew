require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.123-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a434defb07b3125243ffe66fd5ea295d75f71f4579dad87734059dfb6b6bad37',
     armv7l: 'a434defb07b3125243ffe66fd5ea295d75f71f4579dad87734059dfb6b6bad37',
       i686: 'd0f70888b66958aaae4e43ff4c0dc61d4b56fe530524f16dc89e2b15a98a882d',
     x86_64: '1b86fc874084147d5d6d31238b676c3c630a45b44ddd05a8dc38abf99447f5b4'
  })

  depends_on 'python3' => :logical

  no_source_build
end
