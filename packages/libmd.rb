require 'buildsystems/autotools'

class Libmd < Autotools
  description 'libmd provides message digest functions found on BSD systems.'
  homepage 'https://www.hadrons.org/software/libmd/'
  version '1.1.0'
  license 'BSD-3, BSD-2, ISC, Beerware, public-domain'
  compatibility 'all'
  source_url 'https://git.hadrons.org/git/libmd.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ce3644f76c0f6aea9b942e491f24705f7894546a0fa910a7558b95c0fe3f3680',
     armv7l: 'ce3644f76c0f6aea9b942e491f24705f7894546a0fa910a7558b95c0fe3f3680',
       i686: '86b5f02127f17691f83745eb8ca16014342e170fdfc6010a06fe69f0f701a847',
     x86_64: 'c3686286a0de8dae5b6059ef30a262f4586fae65e3196a1b379c840e915b87cd'
  })

  depends_on 'glibc' # R
end
