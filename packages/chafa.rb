require 'buildsystems/autotools'

class Chafa < Autotools
  description 'Image-to-text converter supporting a wide range of symbols and palettes, transparency, animations, etc.'
  homepage 'https://hpjansson.org/chafa/'
  version '1.18.0'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://github.com/hpjansson/chafa.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb196f0966528a8231c9e95872b0fc303b376ba70afc9acd589a33ce2bd7ab90',
     armv7l: 'cb196f0966528a8231c9e95872b0fc303b376ba70afc9acd589a33ce2bd7ab90',
       i686: 'c6b2bd9180497d2ea3c79c429e53aea512e7126d3b0eff0bf63ad0d7996e7761',
     x86_64: 'd81d76468bf1366fedd59afe3ad3a399b8fe992943012f3c6c57a6bbea7cfb7b'
  })

  depends_on 'glib'
  depends_on 'libxslt'

  # The tools depends on freetype, which drops i686 compatibility.
  autotools_configure_options '--without-tools'
end
