require 'buildsystems/autotools'

class Tre < Autotools
  description 'The approximate regex matching library and agrep command line tool.'
  homepage 'https://github.com/laurikari/tre'
  version '07e66d0'
  license 'BSD-2'
  compatibility 'all'
  source_url 'https://github.com/laurikari/tre.git'
  git_hashtag '07e66d07b44ae95a7a89f79c7ce1090f0f4d64db'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52cb371f497a56b4647b1463bf393e1d8fcbcae188e4e7a5748231e49c807389',
     armv7l: '52cb371f497a56b4647b1463bf393e1d8fcbcae188e4e7a5748231e49c807389',
       i686: 'cb7b5c5903676eeff0f8574015c43f4d9d7fa0da7c6aabf22f00b10411cad707',
     x86_64: '5461ed9ebf0e3894502b436cfd87d56bdd89bb741ff1bf31f3f8d635aaa81b1f'
  })

  depends_on 'glibc' # R
end
