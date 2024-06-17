require 'buildsystems/autotools'

class Zvbi < Autotools
  description 'VBI capture and decoding library.'
  homepage 'https://github.com/zapping-vbi/zvbi'
  version '0.2.42-ae74ae51'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'https://github.com/zapping-vbi/zvbi.git'
  git_hashtag 'ae74ae513714f81b9b8abdb12e1b235d16fad74e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5d6a9b7b4005a7cc607d7dbc5b0173c271146f87f1e8d0e9879e1e5f78f56922',
     armv7l: '5d6a9b7b4005a7cc607d7dbc5b0173c271146f87f1e8d0e9879e1e5f78f56922',
       i686: '1b3f4e46881f830c9fd037975d013709ebf606dce98ac5127eca42139aa19045',
     x86_64: '0d57eb9ffae5774b6eac49cf7bb9dfa398561d7c87a95be7527e38f7f4b08db8'
  })

  depends_on 'libpng'
end
