require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.106-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d07661f7db011a7503b4a035a17a090d93a2b89d6fba9305cd269fc12f97bcd',
     armv7l: '9d07661f7db011a7503b4a035a17a090d93a2b89d6fba9305cd269fc12f97bcd',
       i686: '0891d207aca0c80ef9abc1adf010494c3571dddfe1fe776e982a14038bd9d3a3',
     x86_64: 'f29fd9d026da6653af2408e5e2d1b1b18e070fb7de46d9d7dc354647d2df41ec'
  })

  depends_on 'python3' => :logical

  no_source_build
end
