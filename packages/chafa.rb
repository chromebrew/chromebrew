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
    aarch64: 'c0e78ff8255ef75293ef0867fe38b17703cb2ddaa60d9c3ab93365bb79871102',
     armv7l: 'c0e78ff8255ef75293ef0867fe38b17703cb2ddaa60d9c3ab93365bb79871102',
       i686: 'df8189f046b9f2d5092f0874ab880d30e910be4f90470e6aa253f3821fe6a9f0',
     x86_64: '080ce8bc537bbc3f80dffe908160b0960704e5dd2862db7ea89f286899ae9efd'
  })

  depends_on 'glib'
  depends_on 'libxslt'

  # The tools depends on freetype, which drops i686 compatibility.
  autotools_configure_options '--without-tools'
end
