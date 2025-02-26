require 'buildsystems/autotools'

class Bmon < Autotools
  description 'bmon is a commandline bandwidth monitor and rate estimator.'
  homepage 'https://github.com/tgraf/bmon'
  version '4.0'
  license 'BSD-2 and MIT'
  compatibility 'all'
  source_url 'https://github.com/tgraf/bmon.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
     armv7l: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
       i686: 'iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii',
     x86_64: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
  })

  depends_on 'libconfuse'
  depends_on 'libnl3'
  depends_on 'ncurses'

  configure_options '--without-ncurses --with-ncursesw'
end
