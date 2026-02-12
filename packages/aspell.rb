require 'buildsystems/autotools'

class Aspell < Autotools
  description 'GNU Aspell is a Free and Open Source spell checker designed to eventually replace Ispell.'
  homepage 'http://aspell.net/'
  version '0.60.8.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/GNUAspell/aspell.git'
  git_hashtag "rel-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25d813520de5faa008d31572f4d7fbeb9e825c55a881d7a34abd1568981eda62',
     armv7l: '25d813520de5faa008d31572f4d7fbeb9e825c55a881d7a34abd1568981eda62',
       i686: 'd020a095abdd9d034483374f288f758a5058113614fc676dfdd4b396509cf585',
     x86_64: '9f5d7268b6d76d39e24f83c22f6f361ef72998a34d492241947b31429e326e28'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'ncurses' # R
end
