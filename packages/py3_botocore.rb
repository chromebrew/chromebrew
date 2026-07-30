require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.59-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '956ef360232de98a2aa020692b16efb752e096cb864ae39171d80d7961b10073',
     armv7l: '956ef360232de98a2aa020692b16efb752e096cb864ae39171d80d7961b10073',
       i686: 'f970d8da47c3bfe56edb0cec8cddf76480418208f30af2605d338ce06f3c0a4e',
     x86_64: 'e998b1dbb79c3ee199d0d433d9c0aefe5e9d9d553fc4621b517c42236defe490'
  })

  depends_on 'python3' => :logical

  no_source_build
end
