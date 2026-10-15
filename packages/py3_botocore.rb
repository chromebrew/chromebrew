require 'buildsystems/pip'

class Py3_botocore < Pip
  description 'Low-level, data-driven core of boto 3.'
  homepage 'https://github.com/boto/botocore'
  version "1.43.114-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b6f5e27f584010713164a98e1380c886dc9e4e5e0d9b34703cc5e256b020e069',
     armv7l: 'b6f5e27f584010713164a98e1380c886dc9e4e5e0d9b34703cc5e256b020e069',
       i686: '01af4b8a9f5a6f0644890fab369b1ca6a88042943098ffa666c18665bbf5ae25',
     x86_64: '70254b4cc000e3b4ea274d13dedb52ce829744e189780eb3ecd65dfb6e137a64'
  })

  depends_on 'python3' => :logical

  no_source_build
end
