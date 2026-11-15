require 'buildsystems/cmake'

class Faad2 < CMake
  description 'Freeware Advanced Audio (AAC) Decoder'
  homepage 'https://sourceforge.net/projects/faac/'
  version '2.11.4'
  license 'GPL2'
  compatibility 'all'
  source_url 'https://github.com/knik0/faad2.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '65816cd95204474f7f6251b67253108627013734972385c2c9899bbaf7b2fa3a',
     armv7l: '65816cd95204474f7f6251b67253108627013734972385c2c9899bbaf7b2fa3a',
       i686: '77d2cf3e2b995f338d29a76ac2ffb96ea896ca82d8116c428197509d8c0bd594',
     x86_64: '26ff397835bb20ca4e196f15e47f71d008ce343a415746781ae35f04ee03875f'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
end
