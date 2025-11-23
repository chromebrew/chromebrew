require 'buildsystems/cmake'

class Faad2 < CMake
  description 'Freeware Advanced Audio (AAC) Decoder'
  homepage 'https://sourceforge.net/projects/faac/'
  version '2.11.2'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/knik0/faad2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '335da273b197cf7ebeaa1486c13cf5bd5f75fdd195cd980f2307fdda2b76ba08',
     armv7l: '335da273b197cf7ebeaa1486c13cf5bd5f75fdd195cd980f2307fdda2b76ba08',
       i686: 'b45016587d82ce30406358450df33cbf98b9ef6ed563df47df40a44ac23823f6',
     x86_64: '1de0ae79020d437d94e84415434799bcf5f3d5bd72952f709dc5a352c895482e'
  })

  depends_on 'glibc'
end
