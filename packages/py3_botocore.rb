require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.90-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b3858bed6deff668fea50c7425da8ea08d3efb426300a27e190e8e3c876942e8',
     armv7l: 'b3858bed6deff668fea50c7425da8ea08d3efb426300a27e190e8e3c876942e8',
       i686: 'aa4922a23ba7b2aed6005cccd57984305dd480815d90845986cddc7a973d29ab',
     x86_64: 'a88a3d9f27e05d3957ef737deda11498a7585365bbf5b3581497d6ea8e6aa2bc'
  })

  depends_on 'python3' => :logical

  no_source_build
end
