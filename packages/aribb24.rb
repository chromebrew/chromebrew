require 'buildsystems/autotools'

class Aribb24 < Autotools
  description 'aribb24 is a basic implementation of the ARIB STD-B24 public standard.'
  homepage 'https://code.videolan.org/jeeb/aribb24'
  version '1.0.4'
  compatibility 'all'
  license 'LGPL-3'
  source_url 'https://code.videolan.org/jeeb/aribb24.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f8fd427ec1d1dab49ce236e73c81c07f5f63fa983ba35ed23bc822343864bf5d',
     armv7l: 'f8fd427ec1d1dab49ce236e73c81c07f5f63fa983ba35ed23bc822343864bf5d',
       i686: '4e43b212af800a2d6ade6e1a6f98529b9539a982535a511dfb13e53e4d8349f9',
     x86_64: 'c992f12f2b2e99105ed698d23d7d5eb45d1d825e592a3a26e5994a8c96e86ff3'
  })

  depends_on 'glibc' => :library
  depends_on 'libpng' => :library

  run_tests
end
