require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.117-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fd67c71e1f3df258c1acfb6071a879eef1bf7aaeac522409e2010811736bfec3',
     armv7l: 'fd67c71e1f3df258c1acfb6071a879eef1bf7aaeac522409e2010811736bfec3',
       i686: '56df1605b1bf657501c00b069828c446ce3071f9d36ddfb8a433dbf4eb4c74b9',
     x86_64: '4e1886271a5c2a052e7c48114947bda1480cb4da446c62f2fed658a8f56e6429'
  })

  depends_on 'python3' => :logical

  no_source_build
end
