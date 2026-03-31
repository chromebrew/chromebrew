require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.79-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c297b371c65691c312ec5c58a1aa46ac49113d6cf040f65707e30f6b72011997',
     armv7l: 'c297b371c65691c312ec5c58a1aa46ac49113d6cf040f65707e30f6b72011997',
       i686: '3d38f2f087494534a74505f15e6769f2bc4e47a68d252002f24f2635e70f4eb5',
     x86_64: 'b2b89f611d2d3527b3aa743e90e5281173dc507d0797a860de50e17aaf9dda14'
  })

  depends_on 'python3' => :logical

  no_source_build
end
