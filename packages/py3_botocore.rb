require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b95e6ed4a5e888eb72321c7b3b5079e40e5f3ef556e9230f8d0c9d3139d1bfbe',
     armv7l: 'b95e6ed4a5e888eb72321c7b3b5079e40e5f3ef556e9230f8d0c9d3139d1bfbe',
       i686: '055d7f76eef6e1fd3987634d40effe8b092ce7bda11c1dd56b9113e186d02014',
     x86_64: 'd0e8c66d8bd4f818d2b837f0037a7a8fa433af049e6d570b0cfaa63753aec705'
  })

  depends_on 'python3' => :logical

  no_source_build
end
