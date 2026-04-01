require 'buildsystems/autotools'

class Wavpack < Autotools
  description 'WavPack is a completely open audio compression format providing lossless, high-quality lossy, and a unique hybrid compression mode.'
  homepage 'https://www.wavpack.com/'
  version '5.9.0'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/dbry/WavPack.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11776c316379886231bfb839e253a5b333bddca889b115b969dfff77a837d06c',
     armv7l: '11776c316379886231bfb839e253a5b333bddca889b115b969dfff77a837d06c',
       i686: '1fead54e28e000ceae77795ec046795ac9499d87abfd594d79d7bc80910ac662',
     x86_64: '86543791e1d04bbc29d271e24923b08c555f63cfe4153ff39eb999f392e18b68'
  })

  depends_on 'glibc' => :library
end
