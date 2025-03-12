require 'buildsystems/autotools'

class Oniguruma < Autotools
  description 'Oniguruma is a modern and flexible regular expressions library.'
  homepage 'https://github.com/kkos/oniguruma'
  version '6.9.10'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/kkos/oniguruma.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd820f709ae1c955a7ae80597437018135bcb3b82961e68db0eaf4beac179af41',
     armv7l: 'd820f709ae1c955a7ae80597437018135bcb3b82961e68db0eaf4beac179af41',
       i686: '4883e73f1a92dd62fe0545ebd549336f0a39e62c40075b121a7af236187e929d',
     x86_64: 'ef8c2624470d4bc6bd395ace5b1628a857e03ac6edbf10ff6631d92216a45055'
  })

  depends_on 'glibc' # R
end
