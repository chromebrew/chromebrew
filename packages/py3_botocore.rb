require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.70-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '23c6363adcdcdedfb48f17d1a22aa344c83094486213d87093c3fde25bc1af86',
     armv7l: '23c6363adcdcdedfb48f17d1a22aa344c83094486213d87093c3fde25bc1af86',
       i686: '8b20e46f374beae093e6caf4790774d6c94ef479108080612e7c3b016c460a91',
     x86_64: 'b1b3ef74c0e15bf3c6c9ea4985e9843557667739bc8615292fa90382cbd84461'
  })

  depends_on 'python3' => :logical

  no_source_build
end
