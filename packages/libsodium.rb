require 'buildsystems/autotools'

class Libsodium < Autotools
  description 'A modern, portable, easy to use crypto library'
  homepage 'https://libsodium.org'
  version '1.0.19'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/jedisct1/libsodium.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c765b02425358132de3da5df184f990b737bb95bb30746bed2a8cefaf3a4d0e6',
     armv7l: 'c765b02425358132de3da5df184f990b737bb95bb30746bed2a8cefaf3a4d0e6',
       i686: 'f7971a331e7504212dd6c9bc832a8adefca11e95f0494a3ec2579512cc6a64c7',
     x86_64: 'd650cb5469fe83f695b8b8f73f8895229c6f343b7b0b2f644078caf8c5544944'
  })

  run_tests
end
