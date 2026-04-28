require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.42.97-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7549834eb6d1d729341b488b96a71171d5b4010e29e1e3a8254b917a565815ee',
     armv7l: '7549834eb6d1d729341b488b96a71171d5b4010e29e1e3a8254b917a565815ee',
       i686: '7fad2e24f9b44ed8dc89ec509bd599975973023f8c18221b684defda862c1f8e',
     x86_64: '4bc4bf362bcb94c30b15773b9522753679f03d069a97aa4a2352a06479ce8eab'
  })

  depends_on 'python3' => :logical

  no_source_build
end
