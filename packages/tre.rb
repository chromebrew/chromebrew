require 'buildsystems/autotools'

class Tre < Autotools
  description 'The approximate regex matching library and agrep command line tool.'
  homepage 'https://github.com/laurikari/tre'
  version '0.9.0'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/laurikari/tre.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '87204feeb331111669a49a73132929bae6a8a706ff303a4248a64adcda487142',
     armv7l: '87204feeb331111669a49a73132929bae6a8a706ff303a4248a64adcda487142',
       i686: 'fe7347edccdd34846487b84a1c30b1f85c484f7b0b605c4deb9c867d47248a26',
     x86_64: '37a384607697844b2e5b0bcf8160058ad35b60f85e6a0229da81a512426d5fa2'
  })

  depends_on 'glibc' # R
end
