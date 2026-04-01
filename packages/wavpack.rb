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
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })
end
