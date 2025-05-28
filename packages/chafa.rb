require 'buildsystems/autotools'

class Chafa < Autotools
  description 'Image-to-text converter supporting a wide range of symbols and palettes, transparency, animations, etc.'
  homepage 'https://hpjansson.org/chafa/'
  version '1.14.2'
  license 'LGPL'
  compatibility 'all'
  source_url 'https://github.com/hpjansson/chafa.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c827c889582064fcf7d6a054534e85d16595a6bf28e5e3caefcebf1e38c45706',
     armv7l: 'c827c889582064fcf7d6a054534e85d16595a6bf28e5e3caefcebf1e38c45706',
       i686: '615b1997f5b595ad3a95987e649b5aee68b5abc2a3310c6f215de67d6c26d24d',
     x86_64: '01c0d9a470d3cd3241be22fb6ad7dc23b5a6ea3e1ddf7822786a2db5540be274'
  })

  depends_on 'glib'
  depends_on 'libxslt'

  # The tools depends on freetype, which drops i686 compatibility.
  autotools_configure_options '--without-tools'
end
