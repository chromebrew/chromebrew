require 'buildsystems/autotools'

class Tmux < Autotools
  description 'tmux is a terminal multiplexer'
  homepage 'https://tmux.github.io/'
  version '3.4'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/tmux/tmux.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dfe0099a97b2fa8d59d1a75adbc51583236f76c499cae9cd91e984884b157f77',
     armv7l: 'dfe0099a97b2fa8d59d1a75adbc51583236f76c499cae9cd91e984884b157f77',
       i686: '64623bec015fb85c9c3fc1c942f40fdcdaad6cdf137aecf56ca9ba3a32293e34',
     x86_64: '7cff38ef399a12659899b5c40701ba9e17350838013d1ed90890af6cfcf7473a'
  })

  depends_on 'glibc' # R
  depends_on 'libevent' # R
  depends_on 'ncurses' # R
end
