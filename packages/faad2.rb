require 'buildsystems/cmake'

class Faad2 < CMake
  description 'Freeware Advanced Audio (AAC) Decoder'
  homepage 'https://sourceforge.net/projects/faac/'
  version '2.11.3'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/knik0/faad2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a31c4871db43da250a4333ffab199f87ba45b51daec7f0da885f39bc03476ff',
     armv7l: '2a31c4871db43da250a4333ffab199f87ba45b51daec7f0da885f39bc03476ff',
       i686: 'd3ddfb6dcc16d94a363d2874aba5061de8d43595715c1060964e8b749fb9a32e',
     x86_64: '1616cd8ef29d3ef7cde2110e6b891c8839d9c1a33df073b3b8d0758a6df003bf'
  })

  depends_on 'glibc' => :library
end
