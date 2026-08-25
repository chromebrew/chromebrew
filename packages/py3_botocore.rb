require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.79-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '975b49937dfb2c968ea23c1c6c36eb77e7ebd967d6418a1e6fc6fb897a241249',
     armv7l: '975b49937dfb2c968ea23c1c6c36eb77e7ebd967d6418a1e6fc6fb897a241249',
       i686: '0f5023177e80b6f722386a888d59c3ff46e55abe51c12e5ce58990c1280af0a7',
     x86_64: '0a2206a7e83995aa049a27b081254146af4d10d99a506a0111d82743d324cbdc'
  })

  depends_on 'python3' => :logical

  no_source_build
end
